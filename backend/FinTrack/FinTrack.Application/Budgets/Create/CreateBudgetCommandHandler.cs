using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Budget;
using FinTrack.Domain.Shared.ValueObjects;
using FinTrack.Domain.Users;
using SharedKernel;

namespace FinTrack.Application.Budgets.Create;

internal sealed class CreateBudgetCommandHandler(
    IUserContext userContext,
    IBudgetRepository budgetRepository,
    IDateTimeProvider dateTimeProvider,
    IUnitOfWork unitOfWork) : ICommandHandler<CreateBudgetCommand, Guid>
{
    public async Task<Result<Guid>> Handle(CreateBudgetCommand request, CancellationToken cancellationToken)
    {
        if (request.UserId != userContext.UserId)
        {
            return Result.Failure<Guid>(UserErrors.Unauthorized);
        }

        Currency? currency = Currency.FromCode(request.CurrencyCode);
        if (currency is null)
        {
            return Result.Failure<Guid>(CurrencyErrors.NotFound(request.CurrencyCode));
        }

        var money = new Money(request.Amount, currency);

        var budget = Budget.CreateForCurrentMonth(request.UserId, money, dateTimeProvider);

        budgetRepository.Insert(budget);

        await unitOfWork.SaveChangesAsync(cancellationToken);

        return budget.Id;
    }
}
