﻿namespace FinTrack.Domain.Budget.Repositories;

public interface IBudgetRepository
{
    Task<Budget?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);

    Task<List<Budget>> GetByDateAsync(Guid userId, DateOnly dateOnly, CancellationToken cancellationToken = default);

    void Insert(Budget budget);

    void Remove(Budget budget);
}
