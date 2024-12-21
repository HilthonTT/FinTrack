using FinTrack.Domain.Shared.Enums;
using FinTrack.Domain.Subscriptions.Enums;

namespace FinTrack.Contracts.Subscriptions;

public sealed record UpdateSubscriptionRequest(string Name, Frequency Frequency, Company Company);
