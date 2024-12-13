using FinTrack.Application.Abstractions.Emails;
using FinTrack.Application.Users.Register;
using FinTrack.Contracts.Emails;
using FinTrack.Domain.Users;
using FinTrack.Domain.Users.Repositories;
using FinTrack.Events.Abstractions.Messaging;
using MassTransit;
using SharedKernel;

namespace FinTrack.Events.Users.Created;

internal sealed class UserCreatedIntegrationEventHandler(
    IEmailService emailService,
    IUserRepository userRepository) : IIntegrationEventHandler<UserCreatedIntegrationEvent>
{
    public async Task Consume(ConsumeContext<UserCreatedIntegrationEvent> context)
    {
        Guid userId = context.Message.UserId;

        User? user = await userRepository.GetByIdAsync(userId, context.CancellationToken);
        if (user is null)
        {
            throw new DomainException(UserErrors.NotFound(userId));
        }

        // Build the welcome email content
        var mailRequest = new MailRequest(
            user.Email,
            "Welcome to FinTrack!",
            @$"
            <h1>Welcome to FinTrack, {user.Name.Value}!</h1>
            <p>We're excited to have you on board. With FinTrack, you can:</p>
            <ul>
                <li>Track your expenses effortlessly</li>
                <li>Manage your budgets efficiently</li>
                <li>Gain insights into your financial habits</li>
            </ul>
            <p>Get started by logging into your account and exploring all the features we have to offer!</p>
            <p><a href='https://app.fintrack.com/login'>Log in to FinTrack</a></p>
            <p>If you have any questions, feel free to reach out to our support team at <a href='mailto:support@fintrack.com'>support@fintrack.com</a>.</p>
            <p>Happy tracking!<br/>The FinTrack Team</p>");

        await emailService.SendEmailAsync(
            mailRequest,
            isHtml: true,
            cancellationToken: context.CancellationToken);
    }
}
