﻿using Dapper;
using FinTrack.Application.Abstractions.Data;
using Microsoft.Extensions.Logging;
using SharedKernel;
using System.Data;
using System.Diagnostics;

namespace FinTrack.Infrastructure.Authentication;

internal sealed class RevokeRefreshTokensJob(
    IDbConnectionFactory factory,
    IDateTimeProvider dateTimeProvider,
    ILogger<RevokeRefreshTokensJob> logger) : IRevokeRefreshTokensJob
{
    public async Task ExecuteAsync()
    {
        var stopwatch = Stopwatch.StartNew();

        try
        {
            using var connection = await factory.GetOpenConnectionAsync();
            using var transaction = connection.BeginTransaction();

            // Revoke expired tokens
            int expiredCount = await RevokeExpiredTokensAsync(connection, transaction);

            // Revoke duplicate tokens (keep latest per user)
            int duplicatesCount = await RevokeDuplicateTokensAsync(connection, transaction);

            transaction.Commit();

            stopwatch.Stop();

            logger.LogInformation(
                "Revoked {ExpiredCount} expired tokens and {DuplicatesCount} duplicate tokens in {ElapsedMs}ms.",
                expiredCount,
                duplicatesCount,
                stopwatch.ElapsedMilliseconds);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error occurred while revoking refresh tokens.");
            throw;
        }
    }

    private async Task<int> RevokeExpiredTokensAsync(IDbConnection connection, IDbTransaction transaction)
    {
        const string sql = @"
            DELETE FROM refresh_tokens
            WHERE expires_on_utc < @Now";

        int affectedRows = await connection.ExecuteAsync(
            sql,
            new { Now = dateTimeProvider.UtcNow },
            transaction: transaction);

        return affectedRows;
    }

    private static async Task<int> RevokeDuplicateTokensAsync(IDbConnection connection, IDbTransaction transaction)
    {
        const string fetchSql = @"
            WITH ranked_tokens AS (
                SELECT id, user_id, expires_on_utc,
                       ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY expires_on_utc DESC) AS rank
                FROM refresh_tokens
            )
            SELECT id FROM ranked_tokens
            WHERE rank > 1";

        IEnumerable<Guid> duplicateIds = await connection.QueryAsync<Guid>(fetchSql, transaction: transaction);

        if (!duplicateIds.Any())
        {
            return 0;
        }

        const string deleteSql = @"
            DELETE FROM refresh_tokens
            WHERE id = ANY(@Ids)";

        int affectedRows = await connection.ExecuteAsync(
            deleteSql, 
            new { Ids = duplicateIds.ToArray() },
            transaction: transaction);

        return affectedRows;
    }
}
