using SharedKernel;

namespace FinTrack.Domain.Users.ValueObjects;

public static class PasswordErrors
{
    public static readonly Error Empty = Error.Problem(
        "Password.Empty", "The password is empty");

    public static readonly Error TooShort = Error.Problem(
        "Password.TooShort", "The password must be at least 6 characters long");

    public static readonly Error MissingUppercase = Error.Problem(
        "Password.MissingUppercase", "The password must contain at least one uppercase letter");

    public static readonly Error MissingLowercase = Error.Problem(
        "Password.MissingLowercase", "The password must contain at least one lowercase letter");

    public static readonly Error MissingNumber = Error.Problem(
        "Password.MissingNumber", "The password must contain at least one number");

    public static readonly Error MissingSpecialCharacter = Error.Problem(
        "Password.MissingSpecialCharacter", "The password must contain at least one special character");
}
