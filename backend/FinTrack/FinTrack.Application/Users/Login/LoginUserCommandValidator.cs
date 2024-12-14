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
            .MinimumLength(Password.MinimumLength).WithError(UserValidationErrors.PasswordTooShort)
            .Must(Password.ContainUppercase).WithError(UserValidationErrors.PasswordMissingUppercase)
            .Must(Password.ContainLowercase).WithError(UserValidationErrors.PasswordMissingLowercase)
            .Must(Password.ContainNumber).WithError(UserValidationErrors.PasswordMissingNumber)
            .Must(Password.ContainSpecialCharacter).WithError(UserValidationErrors.PasswordMissingSpecialCharacter);
    }
}
