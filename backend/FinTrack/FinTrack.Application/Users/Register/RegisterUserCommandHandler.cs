using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Emails;
using FinTrack.Application.Abstractions.Messaging;
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
    IEmailVerificationLinkFactory emailVerificationLinkFactory,
    IEmailVerificationTokenRepository emailVerificationTokenRepository,
    IEmailService emailService,
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

        string verificationLink = emailVerificationLinkFactory.Create(token);

        var mailRequest = new MailRequest(
            user.Email,
            "Email verification for FinTrack!",
            $"To verify your email address <a href='{verificationLink}'>click here</a>");

        await emailService.SendEmailAsync(
            mailRequest,
            isHtml: true,
            cancellationToken: cancellationToken);

        return user.Id;
    }
}
