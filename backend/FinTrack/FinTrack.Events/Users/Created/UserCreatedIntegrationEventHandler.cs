using FinTrack.Application.Abstractions.Notifications;
using FinTrack.Application.Users.Register;
using FinTrack.Contracts.Emails;
using FinTrack.Domain.Users;
using FinTrack.Domain.Users.Repositories;
using FinTrack.Events.Abstractions.Messaging;
using MassTransit;
using SharedKernel;

namespace FinTrack.Events.Users.Created;

internal sealed class UserCreatedIntegrationEventHandler(
    IEmailNotificationService emailNotificationService,
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

        var welcomeEmail = new WelcomeEmailRequest(user.Email, user.Name);

        await emailNotificationService.SendWelcomeEmailAsync(welcomeEmail, context.CancellationToken);
    }
}
