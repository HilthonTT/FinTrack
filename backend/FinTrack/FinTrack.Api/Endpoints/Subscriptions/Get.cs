﻿using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Subscriptions.Get;
using FinTrack.Contracts.Subscriptions;
using FinTrack.Domain.Users;
using MediatR;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Subscriptions;

internal sealed class Get : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("subscriptions", async (
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var query = new GetSubscriptionsQuery();

            Result<List<SubscriptionResponse>> result = await sender.Send(query, cancellationToken);

            return result.Match(Results.Ok, CustomResults.Problem);
        })
        .WithTags(Tags.Subscriptions)
        .RequireAuthorization()
        .HasPermission(Permission.UsersRead.Name)
        .WithTags(Tags.Subscriptions);
    }
}
