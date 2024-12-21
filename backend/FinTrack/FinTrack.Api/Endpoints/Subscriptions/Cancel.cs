using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Subscriptions.Cancel;
using FinTrack.Domain.Users;
using MediatR;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Subscriptions;

internal sealed class Cancel : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("subscriptions/{subscriptionId:guid}/cancel", async (
            Guid subscriptionId,
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var command = new CancelSubscriptionCommand(subscriptionId);

            Result result = await sender.Send(command, cancellationToken);

            return result.Match(Results.NoContent, CustomResults.Problem);
        })
        .WithTags(Tags.Subscriptions)
        .RequireAuthorization()
        .HasPermission(Permission.UsersRead.Name);
    }
}
