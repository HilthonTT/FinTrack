using MediatR;

namespace FinTrack.Application.Abstractions.Events;

public interface IIntegrationEvent : INotification
{
    Guid Id { get; init; }
}
