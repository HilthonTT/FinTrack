using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Users;

namespace FinTrack.Application.Users.GetCurrent;

public sealed record GetCurrentUserQuery() : IQuery<UserResponse>;
