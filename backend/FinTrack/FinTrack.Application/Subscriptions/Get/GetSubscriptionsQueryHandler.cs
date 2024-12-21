using Dapper;
using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Subscriptions;
using SharedKernel;
using System.Data;

namespace FinTrack.Application.Subscriptions.Get;

internal sealed class GetSubscriptionsQueryHandler(
    IUserContext userContext,
    IDbConnectionFactory factory) : IQueryHandler<GetSubscriptionsQuery, List<SubscriptionResponse>>
{
    public async Task<Result<List<SubscriptionResponse>>> Handle(
        GetSubscriptionsQuery request, 
        CancellationToken cancellationToken)
    {
        const string sql =
            """
            SELECT
                s.id AS Id,
                s.user_id AS UserId,
                s.name AS Name,
                s.amount_amount AS Amount,
                s.amount_currency AS Currency,
                s.frequency AS Frequency,
                s.company AS Company,
                s.subscription_period_start AS PeriodStart,
                s.subscription_period_end AS PeriodEnd,
                s.next_due_date AS NextDueDate,
                s.status AS Status,
                s.created_on_utc AS CreatedOnUtc,
                s.modified_on_utc AS ModifiedOnUtc
            FROM subscriptions s
            WHERE s.user_id = @UserId
            """;

        using IDbConnection connection = await factory.GetOpenConnectionAsync(cancellationToken);

        IEnumerable<SubscriptionResponse> subscriptions = await connection.QueryAsync<SubscriptionResponse>(
            sql,
            new { UserId = userContext.UserId });

        return subscriptions.ToList();
    }
}
