using FinTrack.Application.Core.Extensions;
using FinTrack.Domain.Users.ValueObjects;
using FluentValidation;

namespace FinTrack.Application.Users.Login;

internal sealed class LoginUserCommandValidator : AbstractValidator<LoginUserCommand>
{
	public LoginUserCommandValidator()
	{
		RuleFor(x => x.Email)
			.NotEmpty().WithError(UserValidationErrors.EmailEmpty)
			.EmailAddress().WithError(UserValidationErrors.EmailInvalidFormat);

        RuleFor(x => x.Password)
            .NotEmpty().WithError(UserValidationErrors.PasswordEmpty)
            .MinimumLength(Password.MinimumPasswordLength).WithError(UserValidationErrors.PasswordTooShort)
            .Must(password => password.Any(Password.IsUpper)).WithError(UserValidationErrors.PasswordMissingUppercase)
            .Must(password => password.Any(Password.IsLower)).WithError(UserValidationErrors.PasswordMissingLowercase)
            .Must(password => password.Any(Password.IsDigit)).WithError(UserValidationErrors.PasswordMissingNumber)
            .Must(password => password.Any(Password.IsNonAlphaNumeric)).WithError(UserValidationErrors.PasswordMissingSpecialCharacter);
    }
}
