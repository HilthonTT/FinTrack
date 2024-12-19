using Application.IntegrationTests.Abstractions;
using FinTrack.Application.Users.Register;
using FinTrack.Domain.Users;
using FluentAssertions;
using SharedKernel;

namespace Application.IntegrationTests.Users;

public sealed class RegisterUserTests : BaseIntegrationTest
{
    private const string Password = "AbC-123##!_!XS";

    public RegisterUserTests(IntegrationTestWebAppFactory factory) 
        : base(factory)
    {
    }

    [Fact]
    public async Task Handle_Should_RegisterUser_WhenCommandIsValid()
    {
        // Arrange
        var command = new RegisterUserCommand(
            Faker.Internet.Email(),
            Faker.Internet.UserName(),
            Password);

        // Act
        Result<Guid> result = await Sender.Send(command);

        // Assert
        result.IsSuccess.Should().BeTrue();
    }

    [Fact]
    public async Task Handle_Should_AddUserToDatabase_WhenCommandIsValid()
    {
        var command = new RegisterUserCommand(
            Faker.Internet.Email(),
            Faker.Internet.UserName(),
            Password);

        // Act
        Result<Guid> result = await Sender.Send(command);

        // Assert
        User? user = await AppDbContext.Users.FindAsync(result.Value);

        user.Should().NotBeNull();
    }
}
