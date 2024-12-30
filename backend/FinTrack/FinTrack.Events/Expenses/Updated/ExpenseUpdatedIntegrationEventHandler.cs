using FinTrack.Application.Abstractions.Caching;
using FinTrack.Application.Expenses;
using FinTrack.Application.Expenses.Update;
using FinTrack.Domain.Expenses;
using FinTrack.Domain.Expenses.Repositories;
using FinTrack.Events.Abstractions.Messaging;
using MassTransit;
using SharedKernel;

namespace FinTrack.Events.Expenses.Updated;

internal sealed class ExpenseUpdatedIntegrationEventHandler(
    ICacheService cacheService, 
    IExpenseRepository expenseRepository) : IIntegrationEventHandler<ExpenseUpdatedIntegrationEvent>
{
    public async Task Consume(ConsumeContext<ExpenseUpdatedIntegrationEvent> context)
    {
        Guid expenseId = context.Message.ExpenseId;

        Expense? expense = await expenseRepository.GetByIdAsNoTrackingAsync(expenseId, context.CancellationToken);
        if (expense is null)
        {
            throw new DomainException(ExpenseErrors.NotFound(expenseId));
        }

        string cacheKey = ExpenseCacheKeys.GetUserExpenses(expense.UserId);

        await cacheService.RemoveAsync(cacheKey, context.CancellationToken);

        cacheKey = ExpenseCacheKeys.GetById(expenseId);

        await cacheService.RemoveAsync(cacheKey, context.CancellationToken);
    }
}
