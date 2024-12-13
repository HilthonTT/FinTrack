using SharedKernel;

namespace FinTrack.Application.Users;

public static class UserValidationErrors
{
    public static readonly Error NameEmpty = Error.Problem(
        "UserValidation.NameEmpty",
        "The name is empty");

    public static readonly Error NameTooLong = Error.Problem(
        "UserValidation.NameEmpty",
        "The name is too long");

    public static readonly Error EmailEmpty = Error.Problem(
        "UserValidation.EmailEmpty",
        "The email is empty");

    public static readonly Error EmailInvalidFormat = Error.Problem(
        "UserValidation.EmailInvalidFormat",
        "The email format is invalid");

    public static readonly Error PasswordEmpty = Error.Problem(
       "UserValidation.PasswordEmpty",
       "The password is empty");

    public static readonly Error PasswordTooShort = Error.Problem(
        "UserValidation.PasswordTooShort", 
        "The password must be at least 6 characters long");

    public static readonly Error PasswordMissingUppercase = Error.Problem(
        "UserValidation.PasswordMissingUppercase",
        "The password must contain at least one uppercase letter");

    public static readonly Error PasswordMissingLowercase = Error.Problem(
        "UserValidation.PasswordMissingLowercase",
        "The password must contain at least one lowercase letter");

    public static readonly Error PasswordMissingNumber = Error.Problem(
        "UserValidation.PasswordMissingNumber", 
        "The password must contain at least one number");

    public static readonly Error PasswordMissingSpecialCharacter = Error.Problem(
        "UserValidation.PasswordMissingSpecialCharacter",
        "The password must contain at least one special character");
}
