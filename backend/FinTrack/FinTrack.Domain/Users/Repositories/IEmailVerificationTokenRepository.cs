namespace FinTrack.Domain.Users.Repositories;

public interface IEmailVerificationTokenRepository
{
    Task<EmailVerificationToken?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);

    Task<EmailVerificationToken?> GetMostRecentAsync(Guid userId, CancellationToken cancellationToken = default);

    void Insert(EmailVerificationToken emailVerificationToken);

    void Remove(EmailVerificationToken emailVerificationToken);
}
