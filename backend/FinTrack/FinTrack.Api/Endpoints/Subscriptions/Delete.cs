using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Subscriptions.Delete;
using FinTrack.Domain.Users;
using MediatR;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Subscriptions;

internal sealed class Delete : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapDelete("subscriptions/{subscriptionId:guid}", async (
            Guid subscriptionId,
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var command = new DeleteSubscriptionCommand(subscriptionId);

            Result result = await sender.Send(command, cancellationToken);

            return result.Match(Results.NoContent, CustomResults.Problem);
        })
        .WithTags(Tags.Subscriptions)
        .RequireAuthorization()
        .HasPermission(Permission.UsersRead.Name);
    }
}
