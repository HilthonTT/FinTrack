using FinTrack.Domain.Users;

namespace FinTrack.Application.Abstractions.Authentication;

public interface IEmailVerificationLinkFactory
{
    string Create(EmailVerificationToken emailVerificationToken);
}
