using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Expenses.Get;
using FinTrack.Contracts.Expenses;
using FinTrack.Domain.Users;
using MediatR;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Expenses;

internal sealed class Get : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("expenses", async (ISender sender, CancellationToken cancellationToken) =>
        {
            var query = new GetExpensesQuery();

            Result<List<ExpenseResponse>> result = await sender.Send(query, cancellationToken);

            return result.Match(Results.Ok, CustomResults.Problem);
        })
        .WithTags(Tags.Expenses)
        .RequireAuthorization()
        .HasPermission(Permission.UsersRead.Name);
    }
}
