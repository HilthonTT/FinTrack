using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Budgets.GetByDates;
using FinTrack.Contracts.Budgets;
using FinTrack.Domain.Users;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Budgets;

internal sealed class GetByDates : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("budgets/dates", async (
            [FromQuery] Guid userId,
            [FromQuery] DateOnly startDate,
            [FromQuery] DateOnly endDate,
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var query = new GetBudgetByDatesQuery(userId, startDate, endDate);

            Result<BudgetResponse> result = await sender.Send(query, cancellationToken);

            return result.Match(Results.Ok, CustomResults.Problem);
        })
        .WithTags(Tags.Budgets)
        .RequireAuthorization()
        .HasPermission(Permission.UsersRead.Name);
    }
}
