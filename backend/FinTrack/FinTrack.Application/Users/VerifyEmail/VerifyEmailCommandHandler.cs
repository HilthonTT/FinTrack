using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Users;
using FinTrack.Domain.Users.Repositories;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace FinTrack.Application.Users.VerifyEmail;

internal sealed class VerifyEmailCommandHandler(
    IEmailVerificationTokenRepository emailVerificationTokenRepository,
    IDateTimeProvider dateTimeProvider,
    IUnitOfWork unitOfWork) : ICommandHandler<VerifyEmailCommand>
{
    public async Task<Result> Handle(VerifyEmailCommand request, CancellationToken cancellationToken)
    {
        EmailVerificationToken? token = await emailVerificationTokenRepository.GetByCodeAsync(request.Code, cancellationToken);

        if (token is null || token.ExpiresOnUtc < dateTimeProvider.UtcNow)
        {
            return Result.Failure(EmailVerificationTokenErrors.CannotFindNonExpiredToken);
        }

        if (token.User.EmailVerified)
        {
            return Result.Failure(UserErrors.EmailAlreadyVerified);
        }

        User existingUser = token.User;
        if (unitOfWork.Context.Entry(existingUser).State == EntityState.Detached)
        {
            unitOfWork.Context.Entry(existingUser).State = EntityState.Detached;
        }

        token.User.VerifyEmail();

        token.User.AddRole(Role.Registered);

        emailVerificationTokenRepository.Remove(token);

        await unitOfWork.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
