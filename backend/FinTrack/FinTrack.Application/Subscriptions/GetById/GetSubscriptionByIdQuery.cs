using FinTrack.Application.Abstractions.Caching;
using FinTrack.Contracts.Subscriptions;

namespace FinTrack.Application.Subscriptions.GetById;

public sealed record GetSubscriptionByIdQuery(Guid SubscriptionId) : ICachedQuery<SubscriptionResponse>
{
    public string CacheKey => SubscriptionCacheKeys.GetById(SubscriptionId);

    public TimeSpan? Expiration => null;
}
