using FinTrack.Application.Abstractions.Events;
using MassTransit;

namespace FinTrack.Events.Abstractions.Messaging;

public interface IIntegrationEventHandler<in TIntegrationEvent> : IConsumer<TIntegrationEvent>
    where TIntegrationEvent : class, IIntegrationEvent
{
}