using FinTrack.Domain.Budget;
using FinTrack.Persistence.Context;
using Microsoft.EntityFrameworkCore;

namespace FinTrack.Persistence.Budgets.Repositories;

internal sealed class BudgetRepository(AppDbContext dbContext) : IBudgetRepository
{
    public Task<List<Budget>> GetByDateAsync(Guid userId, DateOnly dateOnly, CancellationToken cancellationToken = default)
    {
        return dbContext.Budgets
            .Where(b => b.DateRange.Start >= dateOnly && b.DateRange.End <= dateOnly && b.UserId == userId)
            .ToListAsync(cancellationToken);
    }

    public Task<Budget?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default)
    {
        return dbContext.Budgets
            .AsSplitQuery()
            .FirstOrDefaultAsync(b => b.Id == id, cancellationToken);
    }

    public void Insert(Budget budget)
    {
        dbContext.Budgets.Add(budget);
    }

    public void Remove(Budget budget)
    {
        dbContext.Budgets.Remove(budget);
    }
}
