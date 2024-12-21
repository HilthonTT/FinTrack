using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Subscriptions.GetById;
using FinTrack.Contracts.Subscriptions;
using FinTrack.Domain.Users;
using MediatR;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Subscriptions;

internal sealed class GetById : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("subscriptions/{subscriptionId:guid}", async (
            Guid subscriptionId,
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var query = new GetSubscriptionByIdQuery(subscriptionId);

            Result<SubscriptionResponse> result = await sender.Send(query, cancellationToken);

            return result.Match(Results.Ok, CustomResults.Problem);
        })
        .WithTags(Tags.Subscriptions)
        .RequireAuthorization()
        .HasPermission(Permission.UsersRead.Name);
    }
}
