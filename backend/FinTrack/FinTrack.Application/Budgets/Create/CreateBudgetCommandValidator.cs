using FinTrack.Application.Core.Extensions;
using FinTrack.Domain.Shared.ValueObjects;
using FluentValidation;

namespace FinTrack.Application.Budgets.Create;

internal sealed class CreateBudgetCommandValidator : AbstractValidator<CreateBudgetCommand>
{
    public CreateBudgetCommandValidator()
    {
        RuleFor(x => x.UserId)
            .NotEmpty()
            .WithError(BudgetValidationErrors.UserIdEmpty);

        RuleFor(x => x.Amount)
            .GreaterThanOrEqualTo(0)
            .WithError(BudgetValidationErrors.AmountCannotBeNegative);

        RuleFor(x => x.CurrencyCode)
            .NotEmpty()
            .WithError(BudgetValidationErrors.CurrencyCodeEmpty)
            .Must(Currency.Any)
            .WithError(BudgetValidationErrors.CurrencyCodeInvalid);

        RuleFor(x => x.StartDate)
            .Must(date => date >= DateOnly.FromDateTime(DateTime.UtcNow))
            .WithError(BudgetValidationErrors.StartDateInPast);

        RuleFor(x => x.EndDate)
            .GreaterThanOrEqualTo(x => x.StartDate)
            .WithError(BudgetValidationErrors.EndDateBeforeStartDate);
    }
}
