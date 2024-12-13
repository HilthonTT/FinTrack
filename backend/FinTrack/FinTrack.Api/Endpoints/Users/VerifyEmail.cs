using FinTrack.Api.Constants;
using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Users;
using FinTrack.Application.Users.VerifyEmail;
using MediatR;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Users;

internal sealed class VerifyEmail : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("users/verify-email", async (
            Guid token,
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var command = new VerifyEmailCommand(token);

            Result result = await sender.Send(command, cancellationToken);

            return result.Match(Results.NoContent, CustomResults.Problem);
        })
        .WithTags(Tags.Users)
        .WithName(UserEndpoints.VerifyEmail)
        .RequireCors(CorsPolicy.AllowAllHeaders);
    }
}
