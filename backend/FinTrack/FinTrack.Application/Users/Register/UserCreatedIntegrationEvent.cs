using FinTrack.Application.Abstractions.Events;

namespace FinTrack.Application.Users.Register;

public sealed record UserCreatedIntegrationEvent(Guid Id, Guid UserId) : IntegrationEvent(Id);
