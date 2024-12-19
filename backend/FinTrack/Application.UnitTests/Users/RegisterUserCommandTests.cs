using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Emails;
using FinTrack.Application.Users.Register;
using FinTrack.Contracts.Emails;
using FinTrack.Domain.Users;
using FinTrack.Domain.Users.Repositories;
using FinTrack.Domain.Users.ValueObjects;
using FluentAssertions;
using NSubstitute;
using SharedKernel;

namespace Application.UnitTests.Users;

public class RegisterUserCommandTests
{
    private static readonly RegisterUserCommand Command = new(
        "test@test.com",
        "test",
        "AbC-123!");

    private readonly RegisterUserCommandHandler _handler;
    private readonly IUserRepository _userRepositoryMock;
    private readonly IPasswordHasher _passwordHasherMock;
    private readonly IDateTimeProvider _dateTimeProviderMock;
    private readonly IEmailVerificationLinkFactory _emailVerificationLinkFactoryMock;
    private readonly IEmailVerificationTokenRepository _emailVerificationTokenRepositoryMock;
    private readonly IEmailService _emailServiceMock;
    private readonly IUnitOfWork _unitOfWorkMock;

    public RegisterUserCommandTests()
    {
        _userRepositoryMock = Substitute.For<IUserRepository>();
        _passwordHasherMock = Substitute.For<IPasswordHasher>();
        _dateTimeProviderMock = Substitute.For<IDateTimeProvider>();
        _emailVerificationLinkFactoryMock = Substitute.For<IEmailVerificationLinkFactory>();
        _emailVerificationTokenRepositoryMock = Substitute.For<IEmailVerificationTokenRepository>();
        _emailServiceMock = Substitute.For<IEmailService>();
        _unitOfWorkMock = Substitute.For<IUnitOfWork>();

        _handler = new(
            _userRepositoryMock,
            _passwordHasherMock,
            _dateTimeProviderMock,
            _emailVerificationLinkFactoryMock,
            _emailVerificationTokenRepositoryMock,
            _emailServiceMock,
            _unitOfWorkMock);
    }

    [Fact]
    public async Task Handle_Should_ReturnError_WhenEmailIsInvalid()
    {
        // Arrange
        RegisterUserCommand invalidCommand = Command with { Email = "invalid_email" };

        // Act
        Result<Guid> result = await _handler.Handle(invalidCommand, default);

        // Assert
        result.Error.Should().Be(EmailErrors.InvalidFormat);
    }

    [Fact]
    public async Task Handle_Should_ReturnError_WhenEmailIsNotUnique()
    {
        // Arrange
        _userRepositoryMock.IsEmailUniqueAsync(Arg.Is<Email>(e => e.Value == Command.Email))
            .Returns(false);

        // Act
        Result<Guid> result = await _handler.Handle(Command, default);

        result.Error.Should().Be(UserErrors.EmailNotUnique);
    }

    [Fact]
    public async Task Handle_Should_ReturnError_WhenCreateSucceeds()
    {
        // Arrange
        _userRepositoryMock.IsEmailUniqueAsync(Arg.Is<Email>(e => e.Value == Command.Email))
            .Returns(true);

        // Act
        Result<Guid> result = await _handler.Handle(Command, default);

        result.IsSuccess.Should().BeTrue();
    }

    [Fact]
    public async Task Handle_Should_CallRepository_WhenCreateSucceeds()
    {
        // Arrange
        _userRepositoryMock.IsEmailUniqueAsync(Arg.Is<Email>(e => e.Value == Command.Email))
            .Returns(true);

        // Act
        Result<Guid> result = await _handler.Handle(Command, default);

        // Assert
        _userRepositoryMock.Received(1).Insert(Arg.Is<User>(u => u.Id == result.Value));
    }

    [Fact]
    public async Task Handle_Should_CallEmailService_WhenCreateSucceeds()
    {
        // Arrange
        _userRepositoryMock.IsEmailUniqueAsync(Arg.Is<Email>(e => e.Value == Command.Email))
            .Returns(true);

        // Act
        await _handler.Handle(Command, default);

        // Assert
        await _unitOfWorkMock.Received(1).SaveChangesAsync(Arg.Any<CancellationToken>());
    }

    [Fact]
    public async Task Handle_Should_CallUnitOfWork_WhenCreateSucceeds()
    {
        // Arrange
        _userRepositoryMock.IsEmailUniqueAsync(Arg.Is<Email>(e => e.Value == Command.Email))
            .Returns(true);

        // Act
        await _handler.Handle(Command, default);

        // Assert
        await _emailServiceMock.Received(1).SendEmailAsync(Arg.Any<MailRequest>(), true, Arg.Any<CancellationToken>());
    }
}
