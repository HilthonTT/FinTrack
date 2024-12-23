using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Budgets.Create;
using FinTrack.Contracts.Budgets;
using FinTrack.Domain.Users;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Budgets;

internal sealed class Create : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("budgets", async (
            [FromHeader(Name = "X-Idempotency-Key")] Guid requestId,
            CreateBudgetRequest request,
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var command = new CreateBudgetCommand(
                requestId, 
                request.UserId,
                request.Name,
                request.Type,
                request.Amount,
                request.CurrencyCode, 
                request.StartDate, 
                request.EndDate);

            Result<Guid> result = await sender.Send(command, cancellationToken);

            return result.Match(Results.Ok, CustomResults.Problem);
        })
        .WithTags(Tags.Budgets)
        .RequireAuthorization()
        .HasPermission(Permission.UsersRead.Name);
    }
}
