using FinTrack.Application.Abstractions.Emails;
using FinTrack.Contracts.Emails;
using FluentEmail.Core;

namespace FinTrack.Infrastructure.Emails;

internal sealed class EmailService(IFluentEmail fluentEmail) : IEmailService
{
    public Task SendEmailAsync(MailRequest mailRequest, bool isHtml, CancellationToken cancellationToken = default)
    {
        return fluentEmail
            .To(mailRequest.EmailTo)
            .Subject(mailRequest.Subject)
            .Body(mailRequest.Body, isHtml)
            .SendAsync(cancellationToken);
    }
}
