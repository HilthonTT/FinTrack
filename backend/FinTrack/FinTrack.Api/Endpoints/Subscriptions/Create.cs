using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Subscriptions.Create;
using FinTrack.Contracts.Subscriptions;
using FinTrack.Domain.Users;
using MediatR;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Subscriptions;

internal sealed class Create : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("subscriptions", async (
            CreateSubscriptionRequest request,
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var command = new CreateSubscriptionCommand(
                request.UserId,
                request.Name,
                request.Amount,
                request.Currency,
                request.Frequency,
                request.Company,
                request.StartDate,
                request.EndDate);

            Result<Guid> result = await sender.Send(command, cancellationToken);

            return result.Match(Results.Ok, CustomResults.Problem);
        })
        .WithTags(Tags.Subscriptions)
        .RequireAuthorization()
        .HasPermission(Permission.UsersRead.Name);
    }
}
