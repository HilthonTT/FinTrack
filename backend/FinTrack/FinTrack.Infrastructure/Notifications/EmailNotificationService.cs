using FinTrack.Application.Abstractions.Emails;
using FinTrack.Application.Abstractions.Notifications;
using FinTrack.Contracts.Emails;

namespace FinTrack.Infrastructure.Notifications;

internal sealed class EmailNotificationService(IEmailService emailService) : IEmailNotificationService
{
    public async Task SendEmailVerificationEmailAsync(
        EmailVerificationEmailRequest request, 
        CancellationToken cancellationToken = default)
    {
        const string subject = "Verify Your Email Address";
        string body = 
            $"""
            Dear User,

            Thank you for signing up for FinTrack! To complete your registration, please verify your email address by entering the following code:

            **{request.Code}**

            If you did not sign up for FinTrack, please ignore this email.

            Thank you,  
            The FinTrack Team
            """;

        var mailRequest = new MailRequest(
            request.EmailTo,
            subject,
            body);

        await emailService.SendEmailAsync(mailRequest, isHtml: true, cancellationToken: cancellationToken);
    }

    public async Task SendWelcomeEmailAsync(
        WelcomeEmailRequest request, 
        CancellationToken cancellationToken = default)
    {
        const string subject = "Welcome to FinTrack!";
        string body = 
            $"""
            Hi {request.name},

            Welcome to FinTrack! We're excited to have you on board. Start tracking your finances effortlessly and take control of your financial goals.

            If you have any questions or need assistance, feel free to reach out to us at [support@fintrack.com](mailto:support@fintrack.com).

            Best regards,  
            The FinTrack Team
            """;

        var mailRequest = new MailRequest(
            request.EmailTo,
            subject,
            body);

        await emailService.SendEmailAsync(mailRequest, isHtml: true, cancellationToken: cancellationToken);
    }
}
