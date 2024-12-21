using Dapper;
using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Subscriptions;
using FinTrack.Domain.Subscriptions;
using FinTrack.Domain.Users;
using SharedKernel;
using System.Data;

namespace FinTrack.Application.Subscriptions.GetById;

internal sealed class GetSubscriptionByIdQueryHandler(
    IDbConnectionFactory factory,
    IUserContext userContext) : IQueryHandler<GetSubscriptionByIdQuery, SubscriptionResponse>
{
    public async Task<Result<SubscriptionResponse>> Handle(GetSubscriptionByIdQuery request, CancellationToken cancellationToken)
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
            WHERE s.id = @SubscriptionId
            """;

        using IDbConnection connection = await factory.GetOpenConnectionAsync(cancellationToken);

        SubscriptionResponse? subscription = await connection.QueryFirstOrDefaultAsync<SubscriptionResponse>(
            sql,
            new { request.SubscriptionId });

        if (subscription is null)
        {
            return Result.Failure<SubscriptionResponse>(SubscriptionErrors.NotFound(request.SubscriptionId));
        }

        if (subscription.UserId != userContext.UserId)
        {
            return Result.Failure<SubscriptionResponse>(UserErrors.Unauthorized);
        }

        return subscription;
    }
}
