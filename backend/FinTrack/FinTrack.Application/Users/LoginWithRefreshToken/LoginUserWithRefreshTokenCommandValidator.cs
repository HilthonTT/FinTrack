using FinTrack.Application.Core.Extensions;
using FluentValidation;

namespace FinTrack.Application.Users.LoginWithRefreshToken;

internal sealed class LoginUserWithRefreshTokenCommandValidator : AbstractValidator<LoginUserWithRefreshTokenCommand>
{
    public LoginUserWithRefreshTokenCommandValidator()
    {
        RuleFor(x => x.RefreshToken).NotEmpty().WithError(UserValidationErrors.RefreshTokenEmpty);
    }
}
