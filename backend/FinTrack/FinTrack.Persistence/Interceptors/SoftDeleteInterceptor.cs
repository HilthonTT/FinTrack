﻿using Microsoft.EntityFrameworkCore.ChangeTracking;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using SharedKernel;
using FinTrack.Domain.Expenses;
using FinTrack.Domain.Shared.ValueObjects;

namespace FinTrack.Persistence.Interceptors;

internal sealed class SoftDeleteInterceptor : SaveChangesInterceptor
{
    public override ValueTask<InterceptionResult<int>> SavingChangesAsync(
        DbContextEventData eventData,
        InterceptionResult<int> result,
        CancellationToken cancellationToken = default)
    {
        if (eventData.Context is not null)
        {
            SoftDeleteEntities(eventData.Context);
        }

        return base.SavingChangesAsync(eventData, result, cancellationToken);
    }

    private static void SoftDeleteEntities(DbContext context)
    {
        DateTime utcNow = DateTime.UtcNow;

        List<EntityEntry<ISoftDeletable>> entities = context
            .ChangeTracker
            .Entries<ISoftDeletable>()
            .Where(e => e.State == EntityState.Deleted)
            .ToList();

        foreach (EntityEntry<ISoftDeletable> entry in entities)
        {
            entry.State = EntityState.Modified;

            entry.Property(e => e.IsDeleted).CurrentValue = true;
            entry.Property(e => e.DeletedOnUtc).CurrentValue = utcNow;

            if (entry.Entity is Expense expense && expense.Money is not null)
            {
                var money = new Money(expense.Money.Amount, expense.Money.Currency);

                expense.UpdateMoney(money);
            }
        }
    }
}
