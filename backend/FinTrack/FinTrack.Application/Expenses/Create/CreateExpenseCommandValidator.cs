using FinTrack.Application.Core.Extensions;
using FinTrack.Domain.Expenses;
using FinTrack.Domain.Shared.Enums;
using FluentValidation;

namespace FinTrack.Application.Expenses.Create;

internal sealed class CreateExpenseCommandValidator : AbstractValidator<CreateExpenseCommand>
{
    public CreateExpenseCommandValidator()
    {
        RuleFor(x => x.UserId)
            .NotEmpty()
            .WithError(ExpenseValidationErrors.UserIdEmpty);

        RuleFor(c => c.Name)
            .NotEmpty()
            .WithError(ExpenseValidationErrors.NameEmpty)
            .MaximumLength(256)
            .WithError(ExpenseValidationErrors.NameTooLong);

        RuleFor(c => c.CurrencyCode)
            .NotEmpty()
            .WithError(ExpenseValidationErrors.CurrencyCodeEmpty);

        RuleFor(c => c.Date)
            .NotEmpty()
            .WithError(ExpenseValidationErrors.DateEmpty);

        RuleFor(c => c.ExpenseCategory)
            .Must(value => Enum.IsDefined(typeof(ExpenseCategory), value))
            .WithError(ExpenseValidationErrors.InvalidExpenseCategory);

        RuleFor(c => c.Company)
            .Must(value => Enum.IsDefined(typeof(Company), value))
            .WithError(ExpenseValidationErrors.InvalidCompany);
    }
}
