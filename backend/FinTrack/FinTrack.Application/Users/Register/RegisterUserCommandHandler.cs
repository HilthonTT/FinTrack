using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Emails;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Application.Abstractions.Notifications;
using FinTrack.Contracts.Emails;
using FinTrack.Domain.Users;
using FinTrack.Domain.Users.Repositories;
using FinTrack.Domain.Users.ValueObjects;
using SharedKernel;

namespace FinTrack.Application.Users.Register;

internal sealed class RegisterUserCommandHandler(
    IUserRepository userRepository,
    IPasswordHasher passwordHasher,
    IDateTimeProvider dateTimeProvider,
    IEmailVerificationTokenRepository emailVerificationTokenRepository,
    IEmailNotificationService emailNotificationService,
    IUnitOfWork unitOfWork) : ICommandHandler<RegisterUserCommand, Guid>
{
    public async Task<Result<Guid>> Handle(RegisterUserCommand request, CancellationToken cancellationToken)
    {
        Result<Email> emailResult = Email.Create(request.Email);
        Result<Password> passwordResult = Password.Create(request.Password);
        Result<Name> nameResult = Name.Create(request.Name);

        Result finalResult = Result.FirstFailureOrSuccess(emailResult, passwordResult, nameResult);
        if (finalResult.IsFailure)
        {
            return Result.Failure<Guid>(finalResult.Error);
        }

        if (!await userRepository.IsEmailUniqueAsync(emailResult.Value, cancellationToken))
        {
            return Result.Failure<Guid>(UserErrors.EmailNotUnique);
        }

        string hashedPassword = passwordHasher.Hash(passwordResult.Value);

        var user = User.Create(
            emailResult.Value,
            nameResult.Value,
            hashedPassword);

        userRepository.Insert(user);

        var token = new EmailVerificationToken(Guid.NewGuid(), user.Id, dateTimeProvider.UtcNow);

        emailVerificationTokenRepository.Insert(token);

        await unitOfWork.SaveChangesAsync(cancellationToken);
    
        await SendVerificationEmail(user, token, cancellationToken);

        return user.Id;
    }

    private async Task SendVerificationEmail(User user, EmailVerificationToken token, CancellationToken cancellationToken)
    {
        var emailVerificationEmail = new EmailVerificationEmailRequest(user.Email, token.Code);

        await emailNotificationService.SendEmailVerificationEmailAsync(emailVerificationEmail, cancellationToken);
    }
}
