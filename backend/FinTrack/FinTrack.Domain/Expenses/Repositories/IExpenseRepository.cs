namespace FinTrack.Domain.Expenses.Repositories;

public interface IExpenseRepository
{
    Task<Expense?> GetByIdAsNoTrackingAsync(Guid id, CancellationToken cancellationToken = default);

    Task<Expense?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);

    void Insert(Expense expense);

    void Remove(Expense expense);
}
