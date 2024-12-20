using SharedKernel;

namespace FinTrack.Domain.Subscriptions.Events;

public sealed record SubscriptionRenewedDomainEvent(Guid SubscriptionId) : IDomainEvent;
