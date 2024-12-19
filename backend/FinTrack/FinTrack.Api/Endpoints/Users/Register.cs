using FinTrack.Api.Constants;
using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Users.Register;
using FinTrack.Contracts.Users;
using MediatR;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Users;

internal sealed class Register : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("users/register", async (
            RegisterRequest request,
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var command = new RegisterUserCommand(request.Email, request.Name, request.Password);

            Result<Guid> result = await sender.Send(command, cancellationToken);

            return result.Match(Results.Ok, CustomResults.Problem);
        })
        .WithTags(Tags.Users)
        .RequireCors(CorsPolicy.AllowAllHeaders);
    }
}
