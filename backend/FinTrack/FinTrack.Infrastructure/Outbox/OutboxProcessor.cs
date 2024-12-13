using Dapper;
using FinTrack.Application.Abstractions.Data;
using Microsoft.Extensions.Logging;
using System.Collections.Concurrent;
using System.Diagnostics;
using System.Text.Json;
using System.Data;
using FinTrack.Domain;
using MediatR;

namespace FinTrack.Infrastructure.Outbox;

internal sealed class OutboxProcessor(
    IDbConnectionFactory factory,
    IPublisher publisher,
    ILogger<OutboxProcessor> logger)
{
    private const int BatchSize = 1000;
    private static readonly ConcurrentDictionary<string, Type> TypeCache = new();

    public async Task<int> Execute(CancellationToken cancellationToken = default)
    {
        var totalStopwatch = Stopwatch.StartNew();

        using IDbConnection connection = await factory.GetOpenConnectionAsync(cancellationToken);
        using IDbTransaction transaction = connection.BeginTransaction();

        List<OutboxMessage> messages = await FetchPendingMessagesAsync(connection, transaction);

        ConcurrentQueue<OutboxUpdate> updateQueue = await ProcessMessagesAsync(messages, cancellationToken);

        await UpdateProcessedMessagesAsync(connection, transaction, updateQueue);

        transaction.Commit();

        totalStopwatch.Stop();

        LogPerformance(totalStopwatch.ElapsedMilliseconds, messages.Count);

        return messages.Count;
    }

    private static async Task<List<OutboxMessage>> FetchPendingMessagesAsync(
        IDbConnection connection,
        IDbTransaction transaction)
    {
        const string sql = @"
            SELECT id AS Id, type AS Type, content AS Content
            FROM outbox_messages
            WHERE processed_on_utc IS NULL
            ORDER BY occurred_on_utc
            LIMIT @BatchSize
            FOR UPDATE SKIP LOCKED";

        IEnumerable<OutboxMessage> messages = await connection.QueryAsync<OutboxMessage>(
            sql,
            new { BatchSize },
            transaction: transaction);

        return messages.AsList();
    }

    private async Task<ConcurrentQueue<OutboxUpdate>> ProcessMessagesAsync(
        List<OutboxMessage> messages,
        CancellationToken cancellationToken)
    {
        var updateQueue = new ConcurrentQueue<OutboxUpdate>();

        IEnumerable<Task> publishTasks = messages
            .Select(message => PublishMessageAsync(message, updateQueue, cancellationToken));

        await Task.WhenAll(publishTasks);

        return updateQueue;
    }

    private async Task PublishMessageAsync(
        OutboxMessage message,
        ConcurrentQueue<OutboxUpdate> updateQueue,
        CancellationToken cancellationToken)
    {
        try
        {
            Type messageType = GetOrAddMessageType(message.Type);

            object deserializedMessage = JsonSerializer.Deserialize(
                message.Content,
                messageType) ?? throw new InvalidOperationException("Deserialization failed");

            await publisher.Publish(deserializedMessage, cancellationToken);

            updateQueue.Enqueue(new OutboxUpdate
            {
                Id = message.Id,
                ProcessedOnUtc = DateTime.UtcNow
            });
        }
        catch (Exception ex)
        {
            updateQueue.Enqueue(new OutboxUpdate
            {
                Id = message.Id,
                ProcessedOnUtc = DateTime.UtcNow,
                Error = ex.ToString()
            });
        }
    }

    private static async Task UpdateProcessedMessagesAsync(
        IDbConnection connection,
        IDbTransaction transaction,
        ConcurrentQueue<OutboxUpdate> updateQueue)
    {
        if (updateQueue.IsEmpty)
        {
            return;
        }

        const string updateSqlTemplate = @"
            UPDATE outbox_messages
            SET processed_on_utc = v.processed_on_utc,
                error = v.error
            FROM (VALUES
                {0}
            ) AS v(id, processed_on_utc, error)
            WHERE outbox_messages.id = v.id::uuid";

        List<OutboxUpdate> updates = [.. updateQueue];

        string valuesList = string.Join(",",
            updates.Select((_, i) => $"(@Id{i}, @ProcessedOn{i}, @Error{i})"));

        var parameters = new DynamicParameters();

        for (int i = 0; i < updates.Count; i++)
        {
            parameters.Add($"Id{i}", updates[i].Id);
            parameters.Add($"ProcessedOn{i}", updates[i].ProcessedOnUtc);
            parameters.Add($"Error{i}", updates[i].Error);
        }

        string updateSql = string.Format(updateSqlTemplate, valuesList);

        await connection.ExecuteAsync(updateSql, parameters, transaction: transaction);
    }

    private static Type GetOrAddMessageType(string typeName)
    {
        Type? type = DomainAssembly.Instance
            .GetTypes()
            .FirstOrDefault(type => type.Name == typeName);

        ArgumentNullException.ThrowIfNull(type, $"Type not found: {typeName}");

        return TypeCache.GetOrAdd(typeName, type);
    }

    private void LogPerformance(long totalTime, int messageCount)
    {
        logger.LogInformation(
            "Processed {MessageCount} outbox messages in {TotalTime}ms.",
            messageCount,
            totalTime);
    }

    private readonly struct OutboxUpdate
    {
        public Guid Id { get; init; }
        public DateTime ProcessedOnUtc { get; init; }
        public string? Error { get; init; }
    }
}