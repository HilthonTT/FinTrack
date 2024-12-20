using SharedKernel;

namespace FinTrack.Application.Users;

internal static class UserValidationErrors
{
    public static readonly Error UserIdEmpty = Error.Problem(
        "UserValidationErrors.UserIdEmpty",
        "The user identifier is empty");

    public static readonly Error NameEmpty = Error.Problem(
        "UserValidationErrors.NameEmpty",
        "The name is empty");

    public static readonly Error NameTooLong = Error.Problem(
        "UserValidationErrors.NameEmpty",
        "The name is too long");

    public static readonly Error EmailEmpty = Error.Problem(
        "UserValidationErrors.EmailEmpty",
        "The email is empty");

    public static readonly Error EmailInvalidFormat = Error.Problem(
        "UserValidationErrors.EmailInvalidFormat",
        "The email format is invalid");

    public static readonly Error PasswordEmpty = Error.Problem(
       "UserValidationErrors.PasswordEmpty",
       "The password is empty");

    public static readonly Error PasswordTooShort = Error.Problem(
        "UserValidationErrors.PasswordTooShort", 
        "The password must be at least 6 characters long");

    public static readonly Error PasswordMissingUppercase = Error.Problem(
        "UserValidationErrors.PasswordMissingUppercase",
        "The password must contain at least one uppercase letter");

    public static readonly Error PasswordMissingLowercase = Error.Problem(
        "UserValidationErrors.PasswordMissingLowercase",
        "The password must contain at least one lowercase letter");

    public static readonly Error PasswordMissingNumber = Error.Problem(
        "UserValidationErrors.PasswordMissingNumber", 
        "The password must contain at least one number");

    public static readonly Error PasswordMissingSpecialCharacter = Error.Problem(
        "UserValidationErrors.PasswordMissingSpecialCharacter",
        "The password must contain at least one special character");

    public static readonly Error CodeEmpty = Error.Problem(
        "UserValidationErrors.CodeEmpty", "The code is empty");

    public static readonly Error RefreshTokenEmpty = Error.Problem(
        "UserValidationErrors.RefreshTokenEmpty",
        "The refresh token is empty");
}
