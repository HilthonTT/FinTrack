namespace FinTrack.Domain.Users.Repositories;

public interface IEmailVerificationTokenRepository
{
    void Insert(EmailVerificationToken emailVerificationToken);
}
