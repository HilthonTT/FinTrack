using FinTrack.Application.Abstractions.Caching;
using FinTrack.Application.Expenses;
using FinTrack.Application.Expenses.Delete;
using FinTrack.Events.Abstractions.Messaging;
using MassTransit;

namespace FinTrack.Events.Expenses.Deleted;

internal sealed class ExpenseDeletedIntegrationEventHandler(ICacheService cacheService)
    : IIntegrationEventHandler<ExpenseDeletedIntegrationEvent>
{
    public async Task Consume(ConsumeContext<ExpenseDeletedIntegrationEvent> context)
    {
        string cacheKey = ExpenseCacheKeys.GetById(context.Message.ExpenseId);

        await cacheService.RemoveAsync(cacheKey, context.CancellationToken);
    }
}
