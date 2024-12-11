namespace FinTrack.Domain.Users.Repositories;

public interface IEmailVerificationTokenRepository
{
    Task<EmailVerificationToken?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);

    void Insert(EmailVerificationToken emailVerificationToken);
}
