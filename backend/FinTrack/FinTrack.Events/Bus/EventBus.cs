using FinTrack.Application.Abstractions.Events;
using MassTransit;

namespace FinTrack.Events.Bus;

internal sealed class EventBus(IBus bus) : IEventBus
{
    public async Task PublishAsync<T>(T integrationEvent, CancellationToken cancellationToken = default)
       where T : class, IIntegrationEvent
    {
        await bus.Publish(integrationEvent, cancellationToken);
    }
}
