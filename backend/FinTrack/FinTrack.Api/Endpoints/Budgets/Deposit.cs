using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Budgets.Deposit;
using FinTrack.Contracts.Budgets;
using FinTrack.Domain.Users;
using MediatR;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Budgets;

internal sealed class Deposit : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("budgets/{budgetId:guid}/deposit", async (
            Guid budgetId,
            DepositBudgetRequest request,
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var command = new DepositBudgetCommand(budgetId, request.UserId, request.Amount);

            Result result = await sender.Send(command, cancellationToken);

            return result.Match(Results.NoContent, CustomResults.Problem);
        })
        .WithTags(Tags.Budgets)
        .RequireAuthorization()
        .HasPermission(Permission.UsersRead.Name);
    }
}
