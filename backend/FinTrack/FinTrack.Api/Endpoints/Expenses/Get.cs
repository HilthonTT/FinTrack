using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Expenses.Get;
using FinTrack.Contracts.Common;
using FinTrack.Contracts.Expenses;
using FinTrack.Domain.Users;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Expenses;

internal sealed class Get : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapGet("expenses", async (
            [FromQuery] string? searchTerm,
            [FromQuery] int pageSize,
            ISender sender, 
            CancellationToken cancellationToken) =>
        {
            var query = new GetExpensesQuery(searchTerm, pageSize);

            Result<PagedList<ExpenseResponse>> result = await sender.Send(query, cancellationToken);

            return result.Match(Results.Ok, CustomResults.Problem);
        })
        .WithTags(Tags.Expenses)
        .RequireAuthorization()
        .HasPermission(Permission.UsersRead.Name);
    }
}
