using FinTrack.Application.Abstractions.Messaging;

namespace FinTrack.Application.Users.VerifyEmail;

public sealed record VerifyEmailCommand(int Code) : ICommand;
