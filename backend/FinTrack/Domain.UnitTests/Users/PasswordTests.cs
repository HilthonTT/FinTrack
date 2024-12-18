using FinTrack.Domain.Users.ValueObjects;
using FluentAssertions;
using SharedKernel;

namespace Domain.UnitTests.Users;

public class PasswordTests
{
    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("short")]
    [InlineData("alllowercase1!")]
    [InlineData("ALLUPPERCASE1!")]
    [InlineData("NoSpecialCharacter1")]
    [InlineData("NoNumber!")]
    [InlineData("123456!")]
    [InlineData("NOSPECIALCHARACTERS123")]
    public void Password_Should_ReturnError_WhenValueIsInvalid(string? value)
    {
        // Act
        Result<Password> result = Password.Create(value);

        // Assert
        result.IsFailure.Should().BeTrue();
    }

    [Theory]
    [InlineData("Valid1!")]
    [InlineData("Str0ngPass!")]
    [InlineData("P@ssw0rd1")]
    [InlineData("T3st!ng123")]
    public void Password_Should_ReturnSuccess_WhenValueIsValid(string value)
    {
        // Act
        Result<Password> result = Password.Create(value);

        // Assert
        result.IsSuccess.Should().BeTrue();
    }
}
