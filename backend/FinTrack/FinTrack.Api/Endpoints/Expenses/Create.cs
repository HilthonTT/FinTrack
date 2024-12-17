using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Expenses.Create;
using FinTrack.Contracts.Expenses;
using FinTrack.Domain.Users;
using MediatR;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Expenses;

internal sealed class Create : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPost("expenses", async (
            CreateExpenseRequest request,
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var command = new CreateExpenseCommand(
                request.UserId,
                request.Name,
                request.Amount,
                request.CurrencyCode,
                request.ExpenseCategory,
                request.SubscriptionType,
                request.TransactionType,
                request.Date);

            Result<Guid> result = await sender.Send(command, cancellationToken);

            return result.Match(Results.Ok, CustomResults.Problem);
        })
        .WithTags(Tags.Expenses)
        .RequireAuthorization()
        .HasPermission(Permission.UsersRead.Name);
    }
}
