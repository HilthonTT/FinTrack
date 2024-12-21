using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Subscriptions.Repositories;
using FinTrack.Domain.Subscriptions;
using FinTrack.Domain.Users;
using SharedKernel;

namespace FinTrack.Application.Subscriptions.Cancel;

internal sealed class CancelSubscriptionCommandHandler(
    IUserContext userContext,
    ISubscriptionRepository subscriptionRepository,
    IUnitOfWork unitOfWork) : ICommandHandler<CancelSubscriptionCommand>
{
    public async Task<Result> Handle(CancelSubscriptionCommand request, CancellationToken cancellationToken)
    {
        Subscription? subscription = await subscriptionRepository.GetByIdAsync(request.SubscriptionId, cancellationToken);
        if (subscription is null)
        {
            return Result.Failure(SubscriptionErrors.NotFound(request.SubscriptionId));
        }

        if (subscription.UserId != userContext.UserId)
        {
            return Result.Failure(UserErrors.Unauthorized);
        }

        subscription.Cancel();

        await unitOfWork.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
