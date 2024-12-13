using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Users;
using FinTrack.Domain.Users.Repositories;
using FinTrack.Domain.Users.ValueObjects;
using SharedKernel;

namespace FinTrack.Application.Users.Register;

internal sealed class RegisterUserCommandHandler(
    IUserRepository userRepository,
    IPasswordHasher passwordHasher,
    IUnitOfWork unitOfWork) : ICommandHandler<RegisterUserCommand>
{
    public async Task<Result> Handle(RegisterUserCommand request, CancellationToken cancellationToken)
    {
        Result<Email> emailResult = Email.Create(request.Email);
        Result<Password> passwordResult = Password.Create(request.Password);
        Result<Name> nameResult = Name.Create(request.Name);

        Result finalResult = Result.FirstFailureOrSuccess(emailResult, passwordResult, nameResult);
        if (finalResult.IsFailure)
        {
            return finalResult;
        }

        if (!await userRepository.IsEmailUniqueAsync(emailResult.Value, cancellationToken))
        {
            return Result.Failure(EmailErrors.NotUnique);
        }

        string hashedPassword = passwordHasher.Hash(passwordResult.Value);

        var user = User.Create(
            emailResult.Value,
            nameResult.Value,
            hashedPassword);

        userRepository.Insert(user);

        await unitOfWork.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
