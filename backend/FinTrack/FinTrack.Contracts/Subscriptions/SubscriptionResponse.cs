using FinTrack.Domain.Shared.Enums;
using FinTrack.Domain.Subscriptions.Enums;

namespace FinTrack.Contracts.Subscriptions;

public sealed class SubscriptionResponse
{
    public required Guid Id { get; set; }

    public required Guid UserId { get; set; }

    public required string Name { get; set; }

    public required decimal Amount { get; set; }

    public required string Currency { get; set; }

    public required Frequency Frequency { get; set; }

    public required Company Company { get; set; }

    public required DateTime PeriodStart { get; set; }

    public required DateTime PeriodEnd { get; set; }

    public required DateTime NextDueDate { get; set; }

    public required Status Status { get; set; }

    public required DateTime CreatedOnUtc { get; set; }

    public required DateTime? ModifiedOnUtc { get; set; }
}