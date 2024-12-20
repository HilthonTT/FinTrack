using Dapper;
using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Expenses;
using FinTrack.Domain.Expenses;
using FinTrack.Domain.Users;
using SharedKernel;
using System.Data;

namespace FinTrack.Application.Expenses.GetById;

internal sealed class GetExpenseByIdQueryHandler(
    IDbConnectionFactory factory,
    IUserContext userContext) : IQueryHandler<GetExpenseByIdQuery, ExpenseResponse>
{
    public async Task<Result<ExpenseResponse>> Handle(GetExpenseByIdQuery request, CancellationToken cancellationToken)
    {
        const string sql =
            """
            SELECT 
                e.id AS Id,
                e.user_id AS UserId,
                e.name AS Name,
                e.money_amount AS Amount,
                e.money_currency AS CurrencyCode,
                e.category AS Category,
                e.company AS Company
                e.date AS Date,
                e.created_on_utc AS CreatedOnUtc,
                e.modified_on_utc AS ModifiedOnUtc
            FROM expenses e
            WHERE e.id = @ExpenseId;
            """;

        using IDbConnection connection = await factory.GetOpenConnectionAsync(cancellationToken);

        ExpenseResponse? expense = await connection.QueryFirstOrDefaultAsync<ExpenseResponse>(
            sql,
            new { ExpenseId = request.ExpenseId });

        if (expense is null)
        {
            return Result.Failure<ExpenseResponse>(ExpenseErrors.NotFound(request.ExpenseId));
        }

        if (expense.UserId != userContext.UserId)
        {
            return Result.Failure<ExpenseResponse>(UserErrors.Unauthorized);
        }

        return expense;
    }
}
