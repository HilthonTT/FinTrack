using FinTrack.Application.Core.Extensions;
using FluentValidation;

namespace FinTrack.Application.Users.RevokeRefreshToken;

internal sealed class RevokeRefreshTokenCommandValidator : AbstractValidator<RevokeRefreshTokenCommand>
{
    public RevokeRefreshTokenCommandValidator()
    {
        RuleFor(x => x.UserId).NotEmpty().WithError(UserValidationErrors.UserIdEmpty);
    }
}
