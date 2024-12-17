using FinTrack.Application.Core.Extensions;
using FinTrack.Domain.Expenses;
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

        RuleFor(c => c.ExpenseCategory)
            .Must(value => Enum.IsDefined(typeof(ExpenseCategory), value))
            .WithError(ExpenseValidationErrors.InvalidExpenseCategory);

        RuleFor(c => c.SubscriptionType)
            .Must(value => Enum.IsDefined(typeof(SubscriptionType), value))
            .WithError(ExpenseValidationErrors.InvalidSubscriptionType);

        RuleFor(c => c.TransactionType)
            .Must(value => Enum.IsDefined(typeof(TransactionType), value))
            .WithError(ExpenseValidationErrors.InvalidTransactionType);
    }
}
