using FinTrack.Contracts.Emails;

namespace FinTrack.Application.Abstractions.Notifications;

public interface IEmailNotificationService
{
    Task SendWelcomeEmailAsync(WelcomeEmailRequest request, CancellationToken cancellationToken = default);

    Task SendEmailVerificationEmailAsync(EmailVerificationEmailRequest request, CancellationToken cancellationToken = default);
}
