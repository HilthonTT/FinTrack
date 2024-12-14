using SharedKernel;

namespace FinTrack.Domain.Users;

public static class UserErrors
{
    public static Error NotFound(Guid userId) => Error.NotFound(
        "User.NotFound",
        $"The user with the Id = '{userId}' was not found");

    public static readonly Error NotFoundByEmail = Error.NotFound(
        "User.NotFoundByEmail",
        "The user with the specified email was not found");

    public static readonly Error EmailNotUnique = Error.Conflict(
        "User.EmailNotUnique",
        "The provided email is not unique");

    public static readonly Error EmailAlreadyVerified = Error.Problem(
        "User.EmailAlreadyVerified",
        "The user already has been verified");

    public static readonly Error Unauthorized = Error.Problem(
        "User.Unauthorized",
        "You are unauthorized to perform this action");
}
