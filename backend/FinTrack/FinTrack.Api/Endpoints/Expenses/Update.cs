using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using FinTrack.Application.Expenses.Update;
using FinTrack.Contracts.Expenses;
using FinTrack.Domain.Users;
using MediatR;
using SharedKernel;

namespace FinTrack.Api.Endpoints.Expenses;

internal sealed class Update : IEndpoint
{
    public void MapEndpoint(IEndpointRouteBuilder app)
    {
        app.MapPatch("expenses/{expenseId:guid}", async (
            Guid expenseId,
            UpdateExpenseRequest request,
            ISender sender,
            CancellationToken cancellationToken) =>
        {
            var command = new UpdateExpenseCommand(expenseId, request.Name, request.Amount, request.Date);

            Result result = await sender.Send(command, cancellationToken);

            return result.Match(Results.NoContent, CustomResults.Problem);
        })
        .WithTags(Tags.Expenses)
        .RequireAuthorization()
        .HasPermission(Permission.UsersRead.Name);
    }
}
