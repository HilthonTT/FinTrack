using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Subscriptions;

namespace FinTrack.Application.Subscriptions.Get;

public sealed record GetSubscriptionsQuery(string? SearchTerm, int Take) : IQuery<List<SubscriptionResponse>>;
