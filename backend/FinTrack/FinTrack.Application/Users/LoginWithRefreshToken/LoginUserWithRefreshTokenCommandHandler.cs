using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Users;
using FinTrack.Domain.Users;
using FinTrack.Domain.Users.Repositories;
using SharedKernel;

namespace FinTrack.Application.Users.LoginWithRefreshToken;

internal sealed class LoginUserWithRefreshTokenCommandHandler(
    IRefreshTokenRepository refreshTokenRepository,
    ITokenProvider tokenProvider,
    IDateTimeProvider dateTimeProvider,
    IUnitOfWork unitOfWork) : ICommandHandler<LoginUserWithRefreshTokenCommand, TokenResponse>
{
    public async Task<Result<TokenResponse>> Handle(
        LoginUserWithRefreshTokenCommand request, 
        CancellationToken cancellationToken)
    {
        RefreshToken? refreshToken = await refreshTokenRepository.GetByTokenAsync(request.RefreshToken, cancellationToken);

        if (refreshToken is null || refreshToken.ExpiresOnUtc < dateTimeProvider.UtcNow)
        {
            return Result.Failure<TokenResponse>(RefreshTokenErrors.Expired);
        }

        string accessToken = tokenProvider.Create(refreshToken.User);

        refreshToken.Update(tokenProvider.GenerateRefreshToken(), dateTimeProvider.UtcNow.AddDays(7));

        await unitOfWork.SaveChangesAsync(cancellationToken);

        return new TokenResponse(accessToken, refreshToken.Token);
    }
}
