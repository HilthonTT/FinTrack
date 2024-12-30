using SharedKernel;

namespace FinTrack.Domain.Subscriptions.Events;

public sealed record SubscriptionUpdatedDomainEvent(Guid SubscriptionId) : IDomainEvent;
