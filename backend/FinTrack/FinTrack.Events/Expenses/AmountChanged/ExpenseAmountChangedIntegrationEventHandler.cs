using FinTrack.Application.Abstractions.Caching;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Expenses;
using FinTrack.Application.Expenses.Update;
using FinTrack.Domain.Budget;
using FinTrack.Domain.Budget.Repositories;
using FinTrack.Domain.Expenses;
using FinTrack.Domain.Expenses.Repositories;
using FinTrack.Events.Abstractions.Messaging;
using MassTransit;
using SharedKernel;

namespace FinTrack.Events.Expenses.AmountChanged;

internal sealed class ExpenseAmountChangedIntegrationEventHandler(
    IExpenseRepository expenseRepository,
    IBudgetRepository budgetRepository,
    IUnitOfWork unitOfWork,
    ICacheService cacheService) : IIntegrationEventHandler<ExpenseAmountChangedIntegrationEvent>
{
    public async Task Consume(ConsumeContext<ExpenseAmountChangedIntegrationEvent> context)
    {
        Guid expenseId = context.Message.ExpenseId;

        Expense? expense = await expenseRepository.GetByIdAsync(expenseId, context.CancellationToken);
        if (expense is null)
        {
            throw new DomainException(ExpenseErrors.NotFound(expenseId));
        }

        DateOnly date = DateOnly.FromDateTime(expense.Date);

        List<Budget> budgets = await budgetRepository.GetByDateAsync(expense.UserId, date, context.CancellationToken);

        List<Budget> budgetsWithCurrency = budgets
            .Where(b => b.Spent.Currency == expense.Money.Currency && b.Amount.Currency == expense.Money.Currency)
            .ToList();

        foreach (Budget budget in budgetsWithCurrency)
        {
            budget.Deposit(context.Message.AmountDifference);
        }

        await unitOfWork.SaveChangesAsync(context.CancellationToken);

        string cacheKey = ExpenseCacheKeys.GetById(expenseId);

        await cacheService.RemoveAsync(cacheKey, context.CancellationToken);
    }
}
