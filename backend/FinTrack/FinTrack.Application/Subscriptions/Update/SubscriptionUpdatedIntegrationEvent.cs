using FinTrack.Application.Abstractions.Events;

namespace FinTrack.Application.Subscriptions.Update;

public sealed record SubscriptionUpdatedIntegrationEvent(Guid Id, Guid SubscriptionId) : IntegrationEvent(Id);
