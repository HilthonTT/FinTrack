using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Expenses;
using FinTrack.Domain.Expenses.Repositories;
using FinTrack.Domain.Users;
using SharedKernel;

namespace FinTrack.Application.Expenses.Delete;

internal sealed class DeleteExpenseCommandHandler(
    IUserContext userContext,
    IExpenseRepository expenseRepository,
    IUnitOfWork unitOfWork) : ICommandHandler<DeleteExpenseCommand>
{
    public async Task<Result> Handle(DeleteExpenseCommand request, CancellationToken cancellationToken)
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

        expenseRepository.Remove(expense);

        await unitOfWork.SaveChangesAsync(cancellationToken);

        return Result.Success();
    }
}
