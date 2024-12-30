using FinTrack.Domain.Expenses;
using FinTrack.Domain.Expenses.Repositories;
using FinTrack.Persistence.Context;
using Microsoft.EntityFrameworkCore;

namespace FinTrack.Persistence.Expenses.Repositories;

internal sealed class ExpenseRepository(AppDbContext dbContext) : IExpenseRepository
{
    public Task<Expense?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default)
    {
        return dbContext.Expenses.FirstOrDefaultAsync(e => e.Id == id, cancellationToken);
    }

    public Task<Expense?> GetByIdAsNoTrackingAsync(Guid id, CancellationToken cancellationToken = default)
    {
        return dbContext
            .Expenses
            .AsNoTracking()
            .FirstOrDefaultAsync(e => e.Id == id, cancellationToken);
    }

    public void Insert(Expense expense)
    {
        dbContext.Expenses.Add(expense);
    }

    public void Remove(Expense expense)
    {
        dbContext.Expenses.Remove(expense);
    }
}
