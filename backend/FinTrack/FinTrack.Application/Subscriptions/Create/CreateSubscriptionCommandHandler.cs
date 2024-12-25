using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Shared.ValueObjects;
using FinTrack.Domain.Subscriptions;
using FinTrack.Domain.Subscriptions.Repositories;
using FinTrack.Domain.Users;
using SharedKernel;

namespace FinTrack.Application.Subscriptions.Create;

internal sealed class CreateSubscriptionCommandHandler(
    IUserContext userContext,
    ISubscriptionRepository subscriptionRepository,
    IUnitOfWork unitOfWork) : ICommandHandler<CreateSubscriptionCommand, Guid>
{
    public async Task<Result<Guid>> Handle(CreateSubscriptionCommand request, CancellationToken cancellationToken)
    {
        if (request.UserId != userContext.UserId)
        {
            return Result.Failure<Guid>(UserErrors.Unauthorized);
        }

        Currency? currency = Currency.FromCode(request.Currency);
        if (currency is null)
        {
            return Result.Failure<Guid>(CurrencyErrors.NotFound(request.Currency));
        }

        var amount = new Money(request.Amount, currency);

        var subscriptionPeriod = DateRange.Create(request.StartDate, request.EndDate);

        var subscription = Subscription.Create(
            userContext.UserId,
            request.Name, 
            amount, 
            request.Frequency, 
            request.Company,
            subscriptionPeriod);

        subscriptionRepository.Insert(subscription);

        await unitOfWork.SaveChangesAsync(cancellationToken);

        return subscription.Id;
    }
}
