using Dapper;
using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Budgets;
using FinTrack.Domain.Budget;
using FinTrack.Domain.Users;
using SharedKernel;
using System.Data;

namespace FinTrack.Application.Budgets.GetById;

internal sealed class GetBudgetByIdQueryHandler(IDbConnectionFactory factory, IUserContext userContext) 
    : IQueryHandler<GetBudgetByIdQuery, BudgetResponse>
{
    public async Task<Result<BudgetResponse>> Handle(GetBudgetByIdQuery request, CancellationToken cancellationToken)
    {
        const string sql =
            """
            SELECT 
                b.id AS Id,
                b.user_id AS UserId,
                b.name AS Name,
                b.type AS Type,
                b.amount_amount AS Amount,
                b.amount_currency AS Currency,
                b.spent_amount AS Spent,
                b.date_range_start AS StartDate,
                b.date_range_end AS EndDate,
                b.created_on_utc AS CreatedOnUtc,
                b.modified_on_utc AS ModifiedOnUtc
            FROM budgets b
            WHERE b.id = @BudgetId
            """;

        using IDbConnection connection = await factory.GetOpenConnectionAsync(cancellationToken);

        BudgetResponse? budget = await connection.QueryFirstOrDefaultAsync<BudgetResponse>(
            sql,
            new { BudgetId = request.BudgetId });

        if (budget is null)
        {
            return Result.Failure<BudgetResponse>(BudgetErrors.NotFound(request.BudgetId));
        }

        if (budget.UserId != userContext.UserId)
        {
            return Result.Failure<BudgetResponse>(UserErrors.Unauthorized);
        }

        budget.AmountLeft = budget.Amount - budget.Spent;

        return budget;
    }
}
