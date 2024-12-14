using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Users;
using FinTrack.Domain.Users.Repositories;
using SharedKernel;

namespace FinTrack.Application.Users.RevokeRefreshToken;

internal sealed class RevokeRefreshTokenCommandHandler(
    IRefreshTokenRepository refreshTokenRepository,
    IUserContext userContext) : ICommandHandler<RevokeRefreshTokenCommand>
{
    public async Task<Result> Handle(RevokeRefreshTokenCommand request, CancellationToken cancellationToken)
    {
        if (request.UserId != userContext.UserId)
        {
            return Result.Failure(UserErrors.Unauthorized);
        }

        await refreshTokenRepository.DeleteAllAsync(userContext.UserId, cancellationToken);

        return Result.Success();
    }
}
