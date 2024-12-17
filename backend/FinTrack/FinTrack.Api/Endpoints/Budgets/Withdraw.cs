using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Budgets.Withdraw;
using FinTrack.Contracts.Budgets;
using FinTrack.Domain.Users;
using MediatR;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Budgets;

internal sealed class Withdraw : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("budgets/{budgetId:guid}/withdraw", async (
            Guid budgetId,
            WithdrawBudgetRequest request,
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var command = new WithdrawBudgetCommand(request.UserId, budgetId, request.Amount);

            Result result = await sender.Send(command, cancellationToken);

            return result.Match(Results.NoContent, CustomResults.Problem);
        })
        .WithTags(Tags.Budgets)
        .RequireAuthorization()
        .HasPermission(Permission.UsersRead.Name);
    }
}
