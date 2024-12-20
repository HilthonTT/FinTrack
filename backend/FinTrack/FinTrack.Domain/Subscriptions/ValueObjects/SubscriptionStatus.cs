using SharedKernel;

namespace FinTrack.Domain.Subscriptions.ValueObjects;

public sealed class SubscriptionStatus : Enumeration<SubscriptionStatus>
{
    public static readonly SubscriptionStatus Active = new(1, "Active");
    public static readonly SubscriptionStatus Canceled = new(2, "Canceled");
    public static readonly SubscriptionStatus Expired = new(3, "Expired");

    private SubscriptionStatus(int id, string name)
        : base(id, name)
    {
    }
}
