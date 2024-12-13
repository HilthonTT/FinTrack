using FinTrack.Application.Abstractions.Events;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Users.Events;

namespace FinTrack.Application.Users.Register;

internal sealed class UserCreatedDomainEventHandler(IEventBus eventBus) : IDomainEventHandler<UserCreatedDomainEvent>
{
    public Task Handle(UserCreatedDomainEvent notification, CancellationToken cancellationToken)
    {
        var integrationEvent = new UserCreatedIntegrationEvent(Guid.NewGuid(), notification.UserId);

        return eventBus.PublishAsync(integrationEvent, cancellationToken);
    }
}
