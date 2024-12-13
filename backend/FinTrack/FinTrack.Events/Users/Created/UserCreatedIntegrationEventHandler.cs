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

        var mailRequest = new MailRequest(user.Email, "Welcome to FinTrack!", "Please register your here email: ");

        await emailService.SendEmailAsync(mailRequest, cancellationToken: context.CancellationToken);
    }
}
