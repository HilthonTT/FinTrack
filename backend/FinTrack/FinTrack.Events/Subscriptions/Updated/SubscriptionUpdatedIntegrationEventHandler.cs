using FinTrack.Application.Abstractions.Caching;
using FinTrack.Application.Subscriptions;
using FinTrack.Application.Subscriptions.Update;
using FinTrack.Domain.Subscriptions;
using FinTrack.Domain.Subscriptions.Repositories;
using FinTrack.Events.Abstractions.Messaging;
using MassTransit;
using SharedKernel;

namespace FinTrack.Events.Subscriptions.Updated;

internal sealed class SubscriptionUpdatedIntegrationEventHandler(
    ISubscriptionRepository subscriptionRepository,
    ICacheService cacheService) : IIntegrationEventHandler<SubscriptionUpdatedIntegrationEvent>
{
    public async Task Consume(ConsumeContext<SubscriptionUpdatedIntegrationEvent> context)
    {
        Guid subscriptionId = context.Message.SubscriptionId;

        Subscription? subscription = await subscriptionRepository.GetByIdAsNoTrackingAsync(
            subscriptionId, 
            context.CancellationToken);

        if (subscription is null)
        {
            throw new DomainException(SubscriptionErrors.NotFound(subscriptionId));
        }

        string cacheKey = SubscriptionCacheKeys.GetById(subscriptionId);

        await cacheService.RemoveAsync(cacheKey, context.CancellationToken);
    }
}
