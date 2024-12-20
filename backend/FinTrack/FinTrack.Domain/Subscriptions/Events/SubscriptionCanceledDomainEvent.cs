using SharedKernel;

namespace FinTrack.Domain.Subscriptions.Events;

public sealed record SubscriptionCanceledDomainEvent(Guid SubscriptionId) : IDomainEvent;
