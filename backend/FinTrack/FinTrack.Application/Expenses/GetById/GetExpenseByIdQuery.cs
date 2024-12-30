using FinTrack.Application.Abstractions.Caching;
using FinTrack.Contracts.Expenses;

namespace FinTrack.Application.Expenses.GetById;

public sealed record GetExpenseByIdQuery(Guid ExpenseId) : ICachedQuery<ExpenseResponse>
{
    public string CacheKey => ExpenseCacheKeys.GetById(ExpenseId);

    public TimeSpan? Expiration => null;
}
