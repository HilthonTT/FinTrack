using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Subscriptions.Update;
using FinTrack.Contracts.Subscriptions;
using FinTrack.Domain.Users;
using MediatR;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Subscriptions;

internal sealed class Update : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPatch("subscriptions/{subscriptionId:guid}", async (
            Guid subscriptionId,
            UpdateSubscriptionRequest request,
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var command = new UpdateSubscriptionCommand(
                subscriptionId,
                request.Name,
                request.Frequency,
                request.Company);

            Result result = await sender.Send(command, cancellationToken);

            return result.Match(Results.NoContent, CustomResults.Problem);
        })
        .WithTags(Tags.Subscriptions)
        .RequireAuthorization()
        .HasPermission(Permission.UsersRead.Name);
    }
}
