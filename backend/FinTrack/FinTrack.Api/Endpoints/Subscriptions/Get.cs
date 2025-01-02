using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Subscriptions.Get;
using FinTrack.Contracts.Common;
using FinTrack.Contracts.Subscriptions;
using FinTrack.Domain.Users;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Subscriptions;

internal sealed class Get : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("subscriptions", async (
            [FromQuery] string? searchTerm,
            [FromQuery] int pageSize,
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var query = new GetSubscriptionsQuery(searchTerm, pageSize);

            Result<PagedList<SubscriptionResponse>> result = await sender.Send(query, cancellationToken);

            return result.Match(Results.Ok, CustomResults.Problem);
        })
        .WithTags(Tags.Subscriptions)
        .RequireAuthorization()
        .HasPermission(Permission.UsersRead.Name)
        .WithTags(Tags.Subscriptions);
    }
}
