using FinTrack.Application.Abstractions.Caching;
using FinTrack.Application.Expenses;
using FinTrack.Application.Expenses.Delete;
using FinTrack.Domain.Expenses;
using FinTrack.Domain.Expenses.Repositories;
using FinTrack.Events.Abstractions.Messaging;
using MassTransit;
using SharedKernel;

namespace FinTrack.Events.Expenses.Deleted;

internal sealed class ExpenseDeletedIntegrationEventHandler(
    ICacheService cacheService,
    IExpenseRepository expenseRepository) : IIntegrationEventHandler<ExpenseDeletedIntegrationEvent>
{
    public async Task Consume(ConsumeContext<ExpenseDeletedIntegrationEvent> context)
    {
        Expense? expense = await expenseRepository.GetByIdAsync(context.Message.ExpenseId, context.CancellationToken);
        if (expense is null)
        {
            throw new DomainException(ExpenseErrors.NotFound(context.Message.ExpenseId));
        }

        string cacheKey = ExpenseCacheKeys.GetUserExpenses(expense.UserId);

        await cacheService.RemoveAsync(cacheKey, context.CancellationToken);
    }
}
