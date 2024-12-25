using FinTrack.Domain.Shared.Enums;
using FinTrack.Domain.Subscriptions.Enums;

namespace FinTrack.Contracts.Subscriptions;

public sealed record CreateSubscriptionRequest(
    Guid UserId,
    string Name,
    decimal Amount,
    string Currency,
    Frequency Frequency,
    Company Company,
    DateOnly StartDate,
    DateOnly EndDate);
