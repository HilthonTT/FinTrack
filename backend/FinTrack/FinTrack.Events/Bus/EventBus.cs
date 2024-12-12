using FinTrack.Application.Abstractions.Events;
using MassTransit;

namespace FinTrack.Events.Bus;

internal sealed class EventBus(IPublishEndpoint publishEndpoint) : IEventBus
{
    public async Task PublishAsync<T>(T integrationEvent, CancellationToken cancellationToken = default)
       where T : class, IIntegrationEvent
    {
        await publishEndpoint.Publish(integrationEvent, cancellationToken);
    }
}
