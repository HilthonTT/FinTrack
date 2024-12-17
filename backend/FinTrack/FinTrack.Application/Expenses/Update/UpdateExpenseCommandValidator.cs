using FinTrack.Application.Core.Extensions;
using FluentValidation;

namespace FinTrack.Application.Expenses.Update;

internal sealed class UpdateExpenseCommandValidator : AbstractValidator<UpdateExpenseCommand>
{
    public UpdateExpenseCommandValidator()
    {
        RuleFor(x => x.ExpenseId)
            .NotEmpty()
            .WithError(ExpenseValidationErrors.ExpenseIdEmpty);

        RuleFor(c => c.Name)
            .NotEmpty()
            .WithError(ExpenseValidationErrors.NameEmpty)
            .MaximumLength(256)
            .WithError(ExpenseValidationErrors.NameTooLong);

        RuleFor(c => c.Date)
            .NotEmpty()
            .WithError(ExpenseValidationErrors.DateEmpty);
    }
}
