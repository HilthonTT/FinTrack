namespace FinTrack.Domain.Expenses.Repositories;

public interface IExpenseRepository
{
    Task<Expense?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);

    void Insert(Expense expense);

    void Remove(Expense expense);
}
