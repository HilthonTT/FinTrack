using FinTrack.Domain.Budget.Events;
using FinTrack.Domain.Shared.ValueObjects;
using SharedKernel;

namespace FinTrack.Domain.Budget;

public sealed class Budget : Entity, IAuditable
{
    private Budget(
        Guid id,
        Guid userId, 
        Money amount, 
        Money spent, 
        DateRange dateRange)
        : base(id)
    {
        Ensure.GreaterThanOrEqualToZero(amount.Amount, nameof(amount));
        Ensure.GreaterThanOrEqualToZero(spent.Amount, nameof(spent));

        UserId = userId;
        Amount = amount;
        Spent = spent;
        DateRange = dateRange;
    }

    private Budget()
    {
        Amount = Money.Zero();
        Spent = Money.Zero();
    }

    public Guid UserId { get; private set; }

    public Money Amount { get; private set; }

    public Money Spent { get; private set; }

    public Money Remaining => Amount - Spent;

    public DateRange DateRange { get; private set; }

    public DateTime CreatedOnUtc { get; set; }

    public DateTime? ModifiedOnUtc { get; set; }

    public static Budget CreateForCurrentMonth(Guid userId, Money amount, IDateTimeProvider dateTimeProvider)
    {
        DateTime utcNow = dateTimeProvider.UtcNow;
        DateOnly start = new(utcNow.Year, utcNow.Month, 1);
        DateOnly end = start.AddMonths(1).AddDays(-1);

        var budget = new Budget(Guid.NewGuid(), userId, amount, Money.Zero(amount.Currency), DateRange.Create(start, end));

        budget.Raise(new BudgetCreatedDomainEvent(budget.Id));

        return budget;
    }

    public Result Withdraw(Money amount)
    {
        if (amount < Money.Zero(amount.Currency))
        {
            return Result.Failure(BudgetErrors.AmountMustBePositive);
        }

        if (Spent + amount > Amount)
        {
            return Result.Failure(BudgetErrors.ExceedsBudgetLimit);
        }

        Spent += amount;

        Raise(new BudgetAmountWithdrawnDomainEvent(Id, amount.Amount));

        return Result.Success();
    }

    public Result Deposit(Money amount)
    {
        if (amount < Money.Zero(amount.Currency))
        {
            return Result.Failure(BudgetErrors.AmountMustBePositive);
        }

        Spent += amount;

        Raise(new BudgetAmountDepositedDomainEvent(Id, amount.Amount));

        return Result.Success();
    }

}
