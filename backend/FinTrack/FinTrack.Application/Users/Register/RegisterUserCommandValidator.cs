using FinTrack.Application.Core.Extensions;
using FinTrack.Domain.Users.ValueObjects;
using FluentValidation;

namespace FinTrack.Application.Users.Register;

internal sealed class RegisterUserCommandValidator : AbstractValidator<RegisterUserCommand>
{
    public RegisterUserCommandValidator()
    {
        // Name validation
        RuleFor(x => x.Name)
            .NotEmpty().WithError(UserValidationErrors.NameEmpty)
            .MaximumLength(Name.MaxLength).WithError(UserValidationErrors.NameTooLong);

        // Email validation
        RuleFor(x => x.Email)
            .NotEmpty().WithError(UserValidationErrors.EmailEmpty)
            .EmailAddress().WithError(UserValidationErrors.EmailInvalidFormat);

        // Password validation
        RuleFor(x => x.Password)
            .NotEmpty().WithError(UserValidationErrors.PasswordEmpty)
            .MinimumLength(Password.MinimumLength).WithError(UserValidationErrors.PasswordTooShort)
            .Must(ContainUppercase).WithError(UserValidationErrors.PasswordMissingUppercase)
            .Must(ContainLowercase).WithError(UserValidationErrors.PasswordMissingLowercase)
            .Must(ContainNumber).WithError(UserValidationErrors.PasswordMissingNumber)
            .Must(ContainSpecialCharacter).WithError(UserValidationErrors.PasswordMissingSpecialCharacter);
    }

    private static bool ContainUppercase(string password) => password.Any(char.IsUpper);

    private static bool ContainLowercase(string password) => password.Any(char.IsLower);

    private static bool ContainNumber(string password) => password.Any(char.IsDigit);

    private static bool ContainSpecialCharacter(string password) =>
        password.Any(ch => !char.IsLetterOrDigit(ch));
}
