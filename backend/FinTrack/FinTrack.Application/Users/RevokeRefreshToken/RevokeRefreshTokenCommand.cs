using FinTrack.Application.Abstractions.Messaging;

namespace FinTrack.Application.Users.RevokeRefreshToken;

public sealed record RevokeRefreshTokenCommand(Guid UserId) : ICommand;
