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
            .MinimumLength(Password.MinimumPasswordLength).WithError(UserValidationErrors.PasswordTooShort)
            .Must(password => password.Any(Password.IsUpper)).WithError(UserValidationErrors.PasswordMissingUppercase)
            .Must(password => password.Any(Password.IsLower)).WithError(UserValidationErrors.PasswordMissingLowercase)
            .Must(password => password.Any(Password.IsDigit)).WithError(UserValidationErrors.PasswordMissingNumber)
            .Must(password => password.Any(Password.IsNonAlphaNumeric)).WithError(UserValidationErrors.PasswordMissingSpecialCharacter);
    }
}
