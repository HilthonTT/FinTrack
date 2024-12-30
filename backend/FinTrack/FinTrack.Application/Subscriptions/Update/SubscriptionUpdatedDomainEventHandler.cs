using FinTrack.Application.Abstractions.Events;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Subscriptions.Events;

namespace FinTrack.Application.Subscriptions.Update;

internal sealed class SubscriptionUpdatedDomainEventHandler(IEventBus eventBus) :
    IDomainEventHandler<SubscriptionUpdatedDomainEvent>,
    IDomainEventHandler<SubscriptionCanceledDomainEvent>,
    IDomainEventHandler<SubscriptionRenewedDomainEvent>
{
    public Task Handle(SubscriptionUpdatedDomainEvent notification, CancellationToken cancellationToken)
    {
        return HandleInternalAsync(notification.SubscriptionId, cancellationToken);
    }

    public Task Handle(SubscriptionCanceledDomainEvent notification, CancellationToken cancellationToken)
    {
        return HandleInternalAsync(notification.SubscriptionId, cancellationToken);
    }

    public Task Handle(SubscriptionRenewedDomainEvent notification, CancellationToken cancellationToken)
    {
        return HandleInternalAsync(notification.SubscriptionId, cancellationToken);
    }

    private async Task HandleInternalAsync(Guid subscriptionId, CancellationToken cancellationToken)
    {
        var integrationEvent = new SubscriptionUpdatedIntegrationEvent(Guid.NewGuid(), subscriptionId);

        await eventBus.PublishAsync(integrationEvent, cancellationToken);
    }
}
