﻿using FinTrack.Domain.Subscriptions;
using FinTrack.Domain.Subscriptions.Repositories;
using FinTrack.Persistence.Context;
using Microsoft.EntityFrameworkCore;

namespace FinTrack.Persistence.Subscriptions.Repositories;

internal sealed class SubscriptionRepository(AppDbContext dbContext) : ISubscriptionRepository
{
    public Task<Subscription?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default)
    {
        return dbContext.Subscriptions.FirstOrDefaultAsync(s => s.Id == id, cancellationToken);
    }

    public Task<Subscription?> GetByIdAsNoTrackingAsync(Guid id, CancellationToken cancellationToken = default)
    {
        return dbContext
            .Subscriptions
            .AsNoTracking()
            .FirstOrDefaultAsync(s => s.Id == id, cancellationToken);
    }

    public void Insert(Subscription subscription)
    {
        dbContext.Subscriptions.Add(subscription);
    }

    public void Remove(Subscription subscription)
    {
        dbContext.Subscriptions.Remove(subscription);
    }
}
