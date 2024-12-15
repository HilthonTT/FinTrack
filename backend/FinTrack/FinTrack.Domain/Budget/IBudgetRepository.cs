namespace FinTrack.Domain.Budget;

public interface IBudgetRepository
{
    Task<Budget?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);

    Task<List<Budget>> GetByDateAndCurrencyAsync(DateOnly dateOnly, CancellationToken cancellationToken = default);

    void Insert(Budget budget);

    void Remove(Budget budget);
}
