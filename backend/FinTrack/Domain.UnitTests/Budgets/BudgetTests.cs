using FinTrack.Domain.Budget;
using FinTrack.Domain.Budget.Enums;
using FinTrack.Domain.Budget.Events;
using FinTrack.Domain.Shared.ValueObjects;
using FluentAssertions;
using NSubstitute;
using SharedKernel;

namespace Domain.UnitTests.Budgets;

public class BudgetTests
{
    private const decimal DummyAmount = 1000m;
    private const decimal DummyWithdrawAmount = 200m;
    private const decimal DummyDepositAmount = 150m;

    private readonly IDateTimeProvider _dateTimeProviderMock; 
    private static readonly Guid DummyUserId = Guid.NewGuid();
    private static readonly Currency TestCurrency = Currency.None;

    public BudgetTests()
    {
        _dateTimeProviderMock = Substitute.For<IDateTimeProvider>();
    }

    [Fact]
    public void CreateForCurrentMonth_Should_CreateBudget_WhenValid()
    {
        // Arrange
        var amount = new Money(DummyAmount, TestCurrency);

        // Act
        var budget = Budget.CreateForCurrentMonth(DummyUserId, "Weekly", BudgetType.Weekly, amount, _dateTimeProviderMock);

        // Assert
        budget.Should().NotBeNull();
        budget.Amount.Should().Be(amount);
        budget.Spent.Should().Be(Money.Zero(TestCurrency));
        budget.Remaining.Should().Be(amount);
        budget.DateRange.Start.Should().Be(DateOnly.FromDateTime(_dateTimeProviderMock.UtcNow).AddDays(1 - _dateTimeProviderMock.UtcNow.Day));
        budget.DateRange.End.Should().Be(DateOnly.FromDateTime(_dateTimeProviderMock.UtcNow).AddMonths(1).AddDays(-1));
    }

    [Fact]
    public void CreateForCurrentMonth_Should_RaiseDomainEvent_WhenValid()
    {
        // Arrange
        var amount = new Money(DummyAmount, TestCurrency);

        // Act
        var budget = Budget.CreateForCurrentMonth(DummyUserId, "Weekly", BudgetType.Weekly, amount, _dateTimeProviderMock);

        // Assert
        budget.DomainEvents
            .Should().ContainSingle()
            .Which
            .Should().BeOfType<BudgetCreatedDomainEvent>();
    }

    [Fact]
    public void Withdraw_Should_Succeed_WhenValid()
    {
        // Arrange
        var amount = new Money(DummyAmount, TestCurrency);
        var budget = Budget.CreateForCurrentMonth(DummyUserId, "Weekly", BudgetType.Weekly, amount, _dateTimeProviderMock);
        var withdrawAmount = new Money(DummyWithdrawAmount, TestCurrency);

        // Clear any existing domain events before deposit
        budget.ClearDomainEvents();

        // Act
        Result result = budget.Withdraw(withdrawAmount);

        // Assert
        result.IsSuccess.Should().BeTrue();
        budget.Spent.Should().Be(withdrawAmount);
        budget.Remaining.Should().Be(amount - withdrawAmount);
        budget.DomainEvents.Should().ContainSingle()
            .Which.Should().BeOfType<BudgetAmountWithdrawnDomainEvent>();
    }

    [Fact]
    public void Withdraw_Should_Fail_When_AmountIsNegative()
    {
        // Arrange
        var amount = new Money(DummyAmount, TestCurrency);
        var budget = Budget.CreateForCurrentMonth(DummyUserId, "Weekly", BudgetType.Weekly, amount, _dateTimeProviderMock);
        var withdrawAmount = new Money(-DummyWithdrawAmount, TestCurrency);

        // Act
        Result result = budget.Withdraw(withdrawAmount);

        // Assert
        result.IsFailure.Should().BeTrue();
        result.Error.Should().Be(BudgetErrors.AmountMustBePositive);
    }

    [Fact]
    public void Withdraw_Should_Fail_When_ExceedsBudgetLimit()
    {
        // Arrange
        var amount = new Money(DummyAmount, TestCurrency);
        var budget = Budget.CreateForCurrentMonth(DummyUserId, "Weekly", BudgetType.Weekly, amount, _dateTimeProviderMock);
        var withdrawAmount = new Money(DummyAmount + 100m, TestCurrency); // Exceeds the amount

        // Act
        Result result = budget.Withdraw(withdrawAmount);

        // Assert
        result.IsFailure.Should().BeTrue();
        result.Error.Should().Be(BudgetErrors.ExceedsBudgetLimit);
    }

    [Fact]
    public void Deposit_Should_Succeed_WhenValid()
    {
        // Arrange
        var amount = new Money(1000M, TestCurrency); // Example amount
        var budget = Budget.CreateForCurrentMonth(DummyUserId, "Weekly", BudgetType.Weekly, amount, _dateTimeProviderMock);
        var withdrawAmount = new Money(300M, TestCurrency); // Example withdrawal
        budget.Withdraw(withdrawAmount);
        budget.ClearDomainEvents();

        var depositAmount = new Money(50M, TestCurrency);

        // Act
        Result result = budget.Deposit(depositAmount);

        // Assert
        result.IsSuccess.Should().BeTrue();
        budget.Spent.Should().Be(withdrawAmount - depositAmount); // 300M - 50M = 250M
        budget.Remaining.Should().Be(amount - budget.Spent);      // 1000M - 250M = 750M
        budget.DomainEvents.Should().ContainSingle()
            .Which.Should().BeOfType<BudgetAmountDepositedDomainEvent>();
    }


    [Fact]
    public void Deposit_Should_Fail_When_AmountIsNegative()
    {
        // Arrange
        var amount = new Money(DummyAmount, TestCurrency);
        var budget = Budget.CreateForCurrentMonth(DummyUserId, "Weekly", BudgetType.Weekly, amount, _dateTimeProviderMock);
        var depositAmount = new Money(-DummyDepositAmount, TestCurrency);

        // Act
        Result result = budget.Deposit(depositAmount);

        // Assert
        result.IsFailure.Should().BeTrue();
        result.Error.Should().Be(BudgetErrors.AmountMustBePositive);
    }

    [Fact]
    public void Deposit_Should_Fail_When_ExceedsSpentAmount()
    {
        // Arrange
        var amount = new Money(1000M, TestCurrency); // Example amount
        var budget = Budget.CreateForCurrentMonth(DummyUserId, "Weekly", BudgetType.Weekly, amount, _dateTimeProviderMock);
        var withdrawAmount = new Money(300M, TestCurrency); // Example withdrawal
        budget.Withdraw(withdrawAmount);

        var depositAmount = new Money(350M, TestCurrency); // Deposit exceeds Spent

        // Act
        Result result = budget.Deposit(depositAmount);

        // Assert
        result.IsFailure.Should().BeTrue();
        result.Error.Should().Be(BudgetErrors.ExceedsSpentAmount);
    }
}
