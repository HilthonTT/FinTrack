using FinTrack.Domain.Shared.Enums;
using FinTrack.Domain.Shared.ValueObjects;
using FinTrack.Domain.Subscriptions.Enums;
using FinTrack.Domain.Subscriptions.Events;
using SharedKernel;

namespace FinTrack.Domain.Subscriptions;

public sealed class Subscription : Entity, IAuditable, ISoftDeletable
{
    private Subscription(
        Guid id, 
        Guid userId, 
        string name, 
        Money amount, 
        Frequency frequency,
        Company company,
        DateRange subscriptionPeriod)
       : base(id)
    {
        Ensure.NotNull(userId, nameof(userId));
        Ensure.NotNullOrWhitespace(name, nameof(name));
        Ensure.NotNull(amount, nameof(amount));
        Ensure.NotNull(frequency, nameof(frequency));
        Ensure.NotNull(subscriptionPeriod, nameof(subscriptionPeriod));

        UserId = userId;
        Name = name;
        Amount = amount;
        Frequency = frequency;
        Company = company;
        SubscriptionPeriod = subscriptionPeriod;
        NextDueDate = CalculateNextDueDate(subscriptionPeriod.Start, frequency);
        Status = Status.Active;
    }

    private Subscription()
    {
    }

    public Guid UserId { get; private set; }

    public string Name { get; private set; }

    public Money Amount { get; private set; }

    public Frequency Frequency { get; private set; }

    public Company Company { get; private set; }

    public DateRange SubscriptionPeriod { get; private set; }

    public DateOnly NextDueDate { get; private set; }

    public Status Status { get; private set; }

    public DateTime CreatedOnUtc { get; set; }

    public DateTime? ModifiedOnUtc { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? DeletedOnUtc { get; set; }

    public static Subscription Create(
        Guid userId,
        string name,
        Money amount, 
        Frequency frequency,
        Company company,
        DateRange subscriptionPeriod)
    {
        var subscription = new Subscription(Guid.NewGuid(), userId, name, amount, frequency, company, subscriptionPeriod);

        subscription.Raise(new SubscriptionCreatedDomainEvent(subscription.Id));

        return subscription;
    }

    public Result Renew(DateOnly paymentDate)
    {
        if (paymentDate != NextDueDate)
        {
            return Result.Failure(SubscriptionErrors.DueDateMustMatchPaymentDate);
        }

        if (Status != Status.Active)
        {
            return Result.Failure(SubscriptionErrors.OnlyActiveSubscriptionsCanBeCanceled);
        }

        NextDueDate = CalculateNextDueDate(paymentDate, Frequency);

        Raise(new SubscriptionRenewedDomainEvent(Id));

        return Result.Success();
    }

    public Result Cancel()
    {
        if (Status != Status.Canceled)
        {
            return Result.Failure(SubscriptionErrors.OnlyActiveSubscriptionsCanBeCanceled);
        }

        Status = Status.Canceled;

        Raise(new SubscriptionCanceledDomainEvent(Id)); 
        
        return Result.Success();
    }

    public Result ChangeName(string name)
    {
        if (string.IsNullOrWhiteSpace(name))
        {
            return Result.Failure(SubscriptionErrors.NameEmpty);
        }

        Name = name;

        return Result.Success();
    }

    public void ChangeFrequency(Frequency frequency)
    {
        Ensure.NotNull(frequency, nameof(frequency));

        Frequency = frequency;
        NextDueDate = CalculateNextDueDate(SubscriptionPeriod.Start, frequency);
    }

    public void ChangeCompany(Company company)
    {
        Ensure.NotNull(company, nameof(company));

        Company = company;
    }

    /// <summary>
    /// Raises the subscription updated domain event.
    /// </summary>
    public void RaiseUpdate()
    {
        Raise(new SubscriptionUpdatedDomainEvent(Id));
    }

    public bool IsPaymentDue(DateOnly today) => Status == Status.Active && today == NextDueDate;

    private static DateOnly CalculateNextDueDate(DateOnly fromDate, Frequency frequency)
    {
        return frequency switch
        {
            Frequency.Daily => fromDate.AddDays(1),
            Frequency.Monthly => fromDate.AddMonths(1),
            Frequency.Yearly => fromDate.AddYears(1),
            _ => throw new ArgumentOutOfRangeException(nameof(frequency), "Unknown frequency type.")
        };
    }
}
