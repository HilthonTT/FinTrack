using FinTrack.Domain.Shared.Enums;
using FinTrack.Domain.Subscriptions.Enums;
using FinTrack.Domain.Subscriptions.ValueObjects;

namespace FinTrack.Contracts.Subscriptions;

public sealed record CreateSubscriptionRequest(
    Guid UserId,
    string Name,
    decimal Amount,
    string CurrencyCode,
    Frequency Frequency,
    Company Company,
    DateOnly StartDate,
    DateOnly EndDate,
    SubscriptionStatus Status);
