using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Budgets.Get;
using FinTrack.Contracts.Budgets;
using FinTrack.Domain.Users;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Budgets;

internal sealed class Get : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("budgets", async (
            [FromQuery] string? searchTerm,
            ISender sender,
            CancellationToken cancellationToken,
            [FromQuery] int take = 10) =>
        {
            var query = new GetBudgetsQuery(searchTerm, take);

            Result<List<BudgetResponse>> result = await sender.Send(query, cancellationToken);

            return result.Match(Results.Ok, CustomResults.Problem);
        })
        .WithTags(Tags.Budgets)
        .RequireAuthorization()
        .HasPermission(Permission.UsersRead.Name);
    }
}
