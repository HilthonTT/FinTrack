using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Subscriptions;

namespace FinTrack.Application.Subscriptions.GetById;

public sealed record GetSubscriptionByIdQuery(Guid SubscriptionId) : IQuery<SubscriptionResponse>;
