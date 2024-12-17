using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Expenses;
using FinTrack.Domain.Expenses.Repositories;
using FinTrack.Domain.Users;
using SharedKernel;

namespace FinTrack.Application.Expenses.Update;

internal sealed class UpdateExpenseCommandHandler(
    IUserContext userContext,
    IExpenseRepository expenseRepository,
    IUnitOfWork unitOfWork) : ICommandHandler<UpdateExpenseCommand>
{
    public async Task<Result> Handle(UpdateExpenseCommand request, CancellationToken cancellationToken)
    {
        Expense? expense = await expenseRepository.GetByIdAsync(request.ExpenseId, cancellationToken);
        if (expense is null)
        {
            return Result.Failure(ExpenseErrors.NotFound(request.ExpenseId));
        }

        if (expense.UserId != userContext.UserId)
        {
            return Result.Failure(UserErrors.Unauthorized);
        }

        Result nameResult = expense.ChangeName(request.Name);
        Result amountResult = expense.ChangeAmount(request.Amount);
        Result dateResult = expense.ChangeDate(request.Date);

        Result firstFailureOrSuccess = Result.FirstFailureOrSuccess(nameResult, amountResult, dateResult);
        if (firstFailureOrSuccess.IsFailure)
        {
            return Result.Failure(firstFailureOrSuccess.Error);
        }

        await unitOfWork.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
