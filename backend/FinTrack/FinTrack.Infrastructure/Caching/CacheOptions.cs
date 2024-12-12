using Microsoft.Extensions.Caching.Distributed;

namespace FinTrack.Infrastructure.Caching;

internal static class CacheOptions
{
    public readonly static DistributedCacheEntryOptions DefaultExpiration = new()
    {
        AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(2),
    };

    public static DistributedCacheEntryOptions Create(TimeSpan? expiration)
    {
        if (expiration is null)
        {
            return DefaultExpiration;
        }

        return new DistributedCacheEntryOptions
        {
            AbsoluteExpirationRelativeToNow = expiration,
        };
    }
}
