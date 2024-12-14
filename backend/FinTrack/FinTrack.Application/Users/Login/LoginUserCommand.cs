using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Users;

namespace FinTrack.Application.Users.Login;

public sealed record LoginUserCommand(string Email, string Password) : ICommand<TokenResponse>;
