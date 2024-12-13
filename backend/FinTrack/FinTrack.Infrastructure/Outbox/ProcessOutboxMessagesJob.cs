using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;

namespace FinTrack.Infrastructure.Outbox;

internal sealed class ProcessOutboxMessagesJob(
    IServiceScopeFactory serviceScopeFactory,
    ILogger<ProcessOutboxMessagesJob> logger) : IProcessOutboxMessagesJob
{
    private const int MaxParallelism = 5;
    private int _totalIterations = 0;
    private int _totalProcessedMessage = 0;

    public async Task ExecuteAsync()
    {
        OutboxLoggers.LogStarting(logger);

        using var cts = new CancellationTokenSource(TimeSpan.FromMinutes(1));

        var parallelOptions = new ParallelOptions
        {
            MaxDegreeOfParallelism = MaxParallelism,
            CancellationToken = cts.Token,
        };

        try
        {
            await Parallel.ForEachAsync(
                Enumerable.Range(0, MaxParallelism),
                parallelOptions,
                async (_, token) =>
                {
                    await ProcessOutboxMessages(token);
                });
        }
        catch (OperationCanceledException)
        {
            OutboxLoggers.LogOperationCancelled(logger);
        }
        catch (Exception ex)
        {
            OutboxLoggers.LogError(logger, ex);
        }
        finally
        {
            OutboxLoggers.LogFinished(logger, _totalIterations, _totalProcessedMessage);
        }
    }
        
    private async Task ProcessOutboxMessages(CancellationToken cancellationToken)
    {
        using IServiceScope scope = serviceScopeFactory.CreateScope();
        var outboxProcessor = scope.ServiceProvider.GetRequiredService<OutboxProcessor>();

        int iterationCount = Interlocked.Increment(ref _totalIterations);
        OutboxLoggers.LogStartingIteration(logger, iterationCount);

        int processedMessages = await outboxProcessor.Execute(cancellationToken);
        int totalProcessedMessages = Interlocked.Add(ref _totalProcessedMessage, processedMessages);

        OutboxLoggers.LogIterationCompleted(logger, iterationCount, processedMessages, totalProcessedMessages); 
    }
}
