namespace FinTrack.Application.Subscriptions;

public static class SubscriptionCacheKeys
{
    public static string GetById(Guid subscriptionId)
    {
        return $"subscription-{subscriptionId}";
    }
}
