using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Users;
using FinTrack.Domain.Users;
using FinTrack.Domain.Users.Repositories;
using FinTrack.Domain.Users.ValueObjects;
using SharedKernel;

namespace FinTrack.Application.Users.Login;

internal sealed class LoginUserCommandHandler(
    IUserRepository userRepository,
    IRefreshTokenRepository refreshTokenRepository,
    IPasswordHasher passwordHasher,
    ITokenProvider tokenProvider,
    IDateTimeProvider dateTimeProvider,
    IUnitOfWork unitOfWork) : ICommandHandler<LoginUserCommand, TokenResponse>
{
    public async Task<Result<TokenResponse>> Handle(LoginUserCommand request, CancellationToken cancellationToken)
    {
        Result<Email> emailResult = Email.Create(request.Email);
        if (emailResult.IsFailure)
        {
            return Result.Failure<TokenResponse>(emailResult.Error);
        }

        User? user = await userRepository.GetByEmailAsync(emailResult.Value, cancellationToken);
        if (user is null)
        {
            return Result.Failure<TokenResponse>(UserErrors.NotFoundByEmail);
        }

        if (!user.EmailVerified)
        {
            return Result.Failure<TokenResponse>(UserErrors.EmailNotVerified);
        }

        bool verified = passwordHasher.Verify(request.Password, user.PasswordHash);

        if (!verified)
        {
            return Result.Failure<TokenResponse>(UserErrors.NotFoundByEmail);
        }

        string token = tokenProvider.Create(user);

        var refreshToken = new RefreshToken(
            Guid.NewGuid(),
            tokenProvider.GenerateRefreshToken(),
            user.Id,
            dateTimeProvider.UtcNow.AddDays(7));

        refreshTokenRepository.Insert(refreshToken);

        await unitOfWork.SaveChangesAsync(cancellationToken);

        return new TokenResponse(token, refreshToken.Token);
    }
}
