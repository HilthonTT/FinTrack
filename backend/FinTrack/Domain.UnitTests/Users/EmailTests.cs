using FinTrack.Domain.Users.ValueObjects;
using FluentAssertions;
using SharedKernel;

namespace Domain.UnitTests.Users;

public class EmailTests
{
    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("plainaddress")]
    [InlineData("missingdomain@")]
    [InlineData("@missingusername.com")]
    [InlineData("missingatsign.com")]
    [InlineData("username@.com.my")]
    [InlineData("username123@gmail.a")]
    [InlineData("username123@.com")]
    [InlineData("username123@.com.com")]
    [InlineData(".username123@gmail.com")]
    [InlineData("username@gmail.com.")]
    [InlineData("username@-domain.com")]
    [InlineData("username@domain..com")]
    [InlineData("username@domain.c")]
    [InlineData("username@domain,com")]
    [InlineData("username@domain;com")]
    [InlineData("username@domain~.com")]
    [InlineData("username@domain!.com")]
    public void Email_Should_ReturnError_WhenValueIsInvalid(string? value)
    {
        // Act
        Result<Email> result = Email.Create(value);

        // Assert
        result.IsFailure.Should().BeTrue();
    }

    [Fact]
    public void Email_Should_ReturnSuccess_WhenValueIsValid()
    {
        // Act
        Result<Email> result = Email.Create("test@test.com");

        // Assert
        result.IsSuccess.Should().BeTrue();
    }
}
