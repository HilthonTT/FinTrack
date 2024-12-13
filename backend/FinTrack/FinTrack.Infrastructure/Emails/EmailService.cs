using FinTrack.Application.Abstractions.Emails;
using FinTrack.Contracts.Emails;
using MailKit.Net.Smtp;
using MailKit.Security;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;
using MimeKit;
using MimeKit.Text;

namespace FinTrack.Infrastructure.Emails;

internal sealed class EmailService(IServiceProvider serviceProvider) : IEmailService
{
    public async Task SendEmailAsync(MailRequest mailRequest, bool isHtml, CancellationToken cancellationToken = default)
    {
        var emailOptions = serviceProvider.GetRequiredService<IOptions<EmailOptions>>().Value;

        var email = new MimeMessage();

        email.From.Add(MailboxAddress.Parse(emailOptions.SenderEmail));
        email.To.Add(MailboxAddress.Parse(mailRequest.EmailTo));

        TextFormat textFormat = isHtml ? TextFormat.Html : TextFormat.Plain;

        email.Subject = mailRequest.Subject;
        email.Body = new TextPart(textFormat)
        {
            Text = mailRequest.Body
        };

        using var smtp = new SmtpClient();

        await smtp.ConnectAsync(emailOptions.Host, emailOptions.Port, SecureSocketOptions.StartTls, cancellationToken);
        await smtp.AuthenticateAsync(emailOptions.Username, emailOptions.Password, cancellationToken);

        await smtp.SendAsync(email, cancellationToken);

        await smtp.DisconnectAsync(true, cancellationToken);
    }
}
