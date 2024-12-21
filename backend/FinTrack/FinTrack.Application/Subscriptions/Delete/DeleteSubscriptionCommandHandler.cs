using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Subscriptions;
using FinTrack.Domain.Subscriptions.Repositories;
using FinTrack.Domain.Users;
using SharedKernel;

namespace FinTrack.Application.Subscriptions.Delete;

internal sealed class DeleteSubscriptionCommandHandler(
    IUserContext userContext,
    ISubscriptionRepository subscriptionRepository,
    IUnitOfWork unitOfWork) : ICommandHandler<DeleteSubscriptionCommand>
{
    public async Task<Result> Handle(DeleteSubscriptionCommand request, CancellationToken cancellationToken)
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

        subscriptionRepository.Remove(subscription);

        await unitOfWork.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
