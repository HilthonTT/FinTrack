using SharedKernel;

namespace FinTrack.Domain.Subscriptions.Events;

public sealed record SubscriptionCreatedDomainEvent(Guid SubscriptionId) : IDomainEvent;
