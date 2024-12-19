using FinTrack.Application.Abstractions.Messaging;

namespace FinTrack.Application.Users.Register;

public sealed record RegisterUserCommand(string Email, string Name, string Password) : ICommand<Guid>;
