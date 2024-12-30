namespace FinTrack.Domain.Subscriptions.Repositories;

public interface ISubscriptionRepository
{
    Task<Subscription?> GetByIdAsNoTrackingAsync(Guid id, CancellationToken cancellationToken = default);

    Task<Subscription?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);

    void Insert(Subscription subscription);

    void Remove(Subscription subscription);
}
