using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Users;

namespace FinTrack.Application.Users.LoginWithRefreshToken;

public sealed record LoginUserWithRefreshTokenCommand(string RefreshToken) : ICommand<TokenResponse>;
