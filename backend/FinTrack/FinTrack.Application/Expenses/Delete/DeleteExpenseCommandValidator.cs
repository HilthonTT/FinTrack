using FinTrack.Application.Core.Extensions;
using FluentValidation;

namespace FinTrack.Application.Expenses.Delete;

internal sealed class DeleteExpenseCommandValidator : AbstractValidator<DeleteExpenseCommand>
{
    public DeleteExpenseCommandValidator()
    {
        RuleFor(x => x.ExpenseId)
            .NotEmpty()
            .WithError(ExpenseValidationErrors.ExpenseIdEmpty);
    }
}
