using FinTrack.Application.Users.Register;
using MediatR;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Users;

internal sealed class Register : IEndpoint
{
    private sealed record Request(string Email, string Name, string Password);

    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("users/register", async (
            Request request,
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var command = new RegisterUserCommand(request.Email, request.Name, request.Password);

            Result result = await sender.Send(command, cancellationToken);

            return result.IsSuccess ? Results.Ok("User registered!") : Results.Problem("Failed to register");
        })
        .WithTags(Tags.Users);
    }
}
