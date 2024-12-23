using Dapper;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Budgets;
using FinTrack.Domain.Budget;
using SharedKernel;
using System.Data;

namespace FinTrack.Application.Budgets.GetByDates;

internal sealed class GetBudgetByDatesQueryHandler(IDbConnectionFactory factory) 
    : IQueryHandler<GetBudgetByDatesQuery, BudgetResponse>
{
    public async Task<Result<BudgetResponse>> Handle(GetBudgetByDatesQuery request, CancellationToken cancellationToken)
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
            WHERE b.user_id = @UserId
              AND b.date_range_start <= @EndDate
              AND b.date_range_end >= @StartDate
            """;

        using IDbConnection connection = await factory.GetOpenConnectionAsync(cancellationToken);

        BudgetResponse? budget = await connection.QueryFirstOrDefaultAsync<BudgetResponse>(
            sql,
            new
            {
                UserId = request.UserId,
                StartDate = request.StartDate,
                EndDate = request.EndDate
            });

        if (budget is null)
        {
            return Result.Failure<BudgetResponse>(BudgetErrors.NotFound(request.StartDate, request.EndDate));
        }

        budget.Remaining = budget.Amount - budget.Spent;

        return budget;
    }
}
