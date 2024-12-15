using FinTrack.Domain.Expenses.Events;
using FinTrack.Domain.Shared.ValueObjects;
using SharedKernel;

namespace FinTrack.Domain.Expenses;

public sealed class Expense : Entity, IAuditable, ISoftDeletable
{
    private Expense(
        Guid id, 
        Guid userId, 
        string name,
        Money money, 
        ExpenseCategory category,
        SubscriptionType subscriptionType, 
        TransactionType transactionType,
        DateTime date) 
        : base(id)
    {
        UserId = userId;
        Name = name;
        Money = money;
        Category = category;
        SubscriptionType = subscriptionType;
        TransactionType = transactionType;
        Date = date;
    }

    private Expense()
    {
    }

    public Guid UserId { get; private set; }


    public string Name { get; private set; }

    public Money Money { get; private set; }

    public ExpenseCategory Category { get; private set; }

    public SubscriptionType SubscriptionType { get; private set; }

    public TransactionType TransactionType { get; private set; }

    public DateTime Date { get; private set; }

    public DateTime CreatedOnUtc { get; set; }

    public DateTime? ModifiedOnUtc { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? DeletedOnUtc { get; set; }

    public static Result<Expense> Create(
        Guid userId, 
        string name, 
        Money money, 
        ExpenseCategory category,
        SubscriptionType subscriptionType, 
        TransactionType transactionType,
        DateTime date)
    {
        if (string.IsNullOrWhiteSpace(name))
        {
            return Result.Failure<Expense>(ExpenseErrors.NameEmpty);
        }

        if (money.Amount < decimal.Zero)
        {
            return Result.Failure<Expense>(ExpenseErrors.AmountIsNegative);
        }

        var expense = new Expense(
            Guid.NewGuid(), 
            userId, 
            name, 
            money, 
            category,
            subscriptionType, 
            transactionType, 
            date);

        expense.Raise(new ExpenseCreatedDomainEvent(expense.Id));

        return expense;
    }

    public Result ChangeAmount(decimal amount)
    {
        if (amount < decimal.Zero)
        {
            return Result.Failure<Expense>(ExpenseErrors.AmountIsNegative);
        }

        if (amount == Money.Amount)
        {
            return Result.Success();
        }

        decimal amountDifference = Money.Amount - amount;

        Money = Money.ChangeAmount(amount);

        Raise(new ExpenseAmountChangedDomainEvent(Id, new Money(amountDifference, Money.Currency)));

        return Result.Success();
    }

    public Result ChangeDate(DateTime date)
    {
        if (Date == date)
        {
            return Result.Success();
        }

        Date = date;

        Raise(new ExpenseDateChangedDomainEvent(Id, Date));

        return Result.Success();
    }
}
