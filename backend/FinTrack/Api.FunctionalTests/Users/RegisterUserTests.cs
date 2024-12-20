using Api.FunctionalTests.Abstractions;
using Api.FunctionalTests.Contracts;
using Api.FunctionalTests.Extensions;
using FinTrack.Application.Users;
using FinTrack.Contracts.Users;
using FluentAssertions;
using System.Net;
using System.Net.Http.Json;

namespace Api.FunctionalTests.Users;

public class RegisterUserTests : BaseFunctionalTest
{
    public RegisterUserTests(FunctionalTestWebAppFactory factory) 
        : base(factory)
    {
    }

    [Fact]
    public async Task Should_ReturnBadRequest_WhenEmailIsMissing()
    {
        // Arrange
        var request = new RegisterRequest("", "Name", "AbC-123!");

        // Act
        HttpResponseMessage response = await HttpClient.PostAsJsonAsync("api/v1/users/register", request);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.BadRequest);

        CustomProblemDetails problemDetails = await response.GetProblemDetails();

        problemDetails.Errors.Select(e => e.Code)
            .Should()
            .Contain([
                UserValidationErrors.EmailEmpty.Code,
                UserValidationErrors.EmailInvalidFormat.Code,
            ]);
    }

    [Fact]
    public async Task Should_ReturnBadRequest_WhenNameIsMissing()
    {
        // Arrange
        var request = new RegisterRequest("test@test.com", "", "AbC-123!");

        // Act
        HttpResponseMessage response = await HttpClient.PostAsJsonAsync("api/v1/users/register", request);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.BadRequest);

        CustomProblemDetails problemDetails = await response.GetProblemDetails();

        problemDetails.Errors.Select(e => e.Code)
            .Should()
            .Contain([
                UserValidationErrors.NameEmpty.Code,
            ]);
    }

    [Fact]
    public async Task Should_ReturnBadRequest_WhenPasswordIsMissing()
    {
        // Arrange
        var request = new RegisterRequest("test@test.com", "Name", "");

        // Act
        HttpResponseMessage response = await HttpClient.PostAsJsonAsync("api/v1/users/register", request);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.BadRequest);

        CustomProblemDetails problemDetails = await response.GetProblemDetails();

        problemDetails.Errors.Select(e => e.Code)
            .Should()
            .Contain([
                UserValidationErrors.PasswordEmpty.Code,
                UserValidationErrors.PasswordTooShort.Code,
                UserValidationErrors.PasswordMissingUppercase.Code,
                UserValidationErrors.PasswordMissingLowercase.Code,
                UserValidationErrors.PasswordMissingNumber.Code,
                UserValidationErrors.PasswordMissingSpecialCharacter.Code,
            ]);
    }

    [Fact]
    public async Task Should_ReturnOk_WhenRequestIsValid()
    {
        // Arrange
        var request = new RegisterRequest("test@test.com", "Name", "AbC-123!");

        // Act
        HttpResponseMessage response = await HttpClient.PostAsJsonAsync("api/v1/users/register", request);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.OK);
    }

    [Fact]
    public async Task Should_ReturnConflict_WhenUserExists()
    {
        // Arrange
        var request = new RegisterRequest("test@test.com", "Name", "AbC-123!");

        // Act
        await HttpClient.PostAsJsonAsync("api/v1/users/register", request);

        HttpResponseMessage response = await HttpClient.PostAsJsonAsync("api/v1/users/register", request);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.Conflict);
    }
}
