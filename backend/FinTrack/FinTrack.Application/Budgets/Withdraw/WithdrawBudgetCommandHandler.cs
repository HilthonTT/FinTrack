using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Budget;
using FinTrack.Domain.Budget.Repositories;
using FinTrack.Domain.Shared.ValueObjects;
using FinTrack.Domain.Users;
using SharedKernel;

namespace FinTrack.Application.Budgets.Withdraw;

internal sealed class WithdrawBudgetCommandHandler(
    IUserContext userContext,
    IBudgetRepository budgetRepository,
    IUnitOfWork unitOfWork) : ICommandHandler<WithdrawBudgetCommand>
{
    public async Task<Result> Handle(WithdrawBudgetCommand request, CancellationToken cancellationToken)
    {
        if (request.UserId != userContext.UserId)
        {
            return Result.Failure(UserErrors.Unauthorized);
        }

        Budget? budget = await budgetRepository.GetByIdAsync(request.BudgetId, cancellationToken);
        if (budget is null)
        {
            return Result.Failure(BudgetErrors.NotFound(request.BudgetId));
        }

        if (budget.UserId != userContext.UserId)
        {
            return Result.Failure(UserErrors.Unauthorized);
        }

        var money = new Money(request.Amount, budget.Amount.Currency);

        budget.Withdraw(money);

        await unitOfWork.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
