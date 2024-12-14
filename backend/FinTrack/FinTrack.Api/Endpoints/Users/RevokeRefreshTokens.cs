using FinTrack.Api.Constants;
using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Users.RevokeRefreshToken;
using MediatR;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Users;

internal sealed class RevokeRefreshTokens : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapDelete("users/{userId:guid}/refresh-tokens", async (
            Guid userId,
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var command = new RevokeRefreshTokenCommand(userId);

            Result result = await sender.Send(command, cancellationToken);

            return result.Match(Results.NoContent, CustomResults.Problem);
        })
        .WithTags(Tags.Users)
        .RequireCors(CorsPolicy.AllowAllHeaders)
        .RequireAuthorization();
    }
}
