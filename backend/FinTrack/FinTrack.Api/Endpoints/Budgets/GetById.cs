using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Budgets.GetById;
using FinTrack.Contracts.Budgets;
using FinTrack.Domain.Users;
using MediatR;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Budgets;

internal sealed class GetById : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("budgets/{budgetId:guid}", async (
            Guid budgetId,
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var query = new GetBudgetByIdQuery(budgetId);

            Result<BudgetResponse> result = await sender.Send(query, cancellationToken);

            return result.Match(Results.Ok, CustomResults.Problem);
        })
        .WithTags(Tags.Budgets)
        .RequireAuthorization()
        .HasPermission(Permission.UsersRead.Name);
    }
}
