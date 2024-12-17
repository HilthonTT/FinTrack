using Dapper;
using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Expenses;
using SharedKernel;
using System.Data;

namespace FinTrack.Application.Expenses.Get;

internal sealed class GetExpensesQueryHandler(
    IDbConnectionFactory factory,
    IUserContext userContext) : IQueryHandler<GetExpensesQuery, List<ExpenseResponse>>
{
    public async Task<Result<List<ExpenseResponse>>> Handle(
        GetExpensesQuery request, 
        CancellationToken cancellationToken)
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
                e.subscription_type AS SubscriptionType,
                e.transaction_type AS TransactionType,
                e.date AS Date,
                e.created_on_utc AS CreatedOnUtc,
                e.modified_on_utc AS ModifiedOnUtc
            FROM expenses e
            WHERE e.user_id = @UserId;
            """;

        using IDbConnection connection = await factory.GetOpenConnectionAsync(cancellationToken);

        IEnumerable<ExpenseResponse> expenses = await connection.QueryAsync<ExpenseResponse>(
            sql,
            new { UserId = userContext.UserId });

        return expenses.ToList();
    }
}
