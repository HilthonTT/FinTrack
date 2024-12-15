using FinTrack.Domain.Users;
using FinTrack.Domain.Users.Events;
using FinTrack.Domain.Users.ValueObjects;
using FluentAssertions;

namespace Domain.UnitTests.Users;

public class UserTests
{
    private const string DummyPasswordHash = nameof(DummyPasswordHash);

    [Fact]
    public void Create_Should_CreateUser_WhenValid()
    {
        // Arrange
        Email email = Email.Create("test@test.com").Value;
        Name name = Name.Create("Hilbert").Value;

        // Act
        var user = User.Create(email, name, DummyPasswordHash);

        // Assert
        user.Should().NotBeNull();
    }

    [Fact]
    public void Create_Should_RaiseDomainEvent_WhenValid()
    {
        // Arrange
        Email email = Email.Create("test@test.com").Value;
        Name name = Name.Create("Hilbert").Value;

        // Act
        var user = User.Create(email, name, DummyPasswordHash);

        // Assert
        user.DomainEvents
            .Should().ContainSingle()
            .Which
            .Should().BeOfType<UserCreatedDomainEvent>();
    }
}
