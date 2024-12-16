using FinTrack.Application.Core.Extensions;
using FluentValidation;

namespace FinTrack.Application.Budgets.Deposit;

internal sealed class DepositBudgetCommandValidator : AbstractValidator<DepositBudgetCommand>
{
    public DepositBudgetCommandValidator()
    {
        RuleFor(x => x.UserId).NotEmpty().WithError(BudgetValidationErrors.UserIdEmpty);

        RuleFor(x => x.BudgetId).NotEmpty().WithError(BudgetValidationErrors.BudgetIdEmpty);

        RuleFor(x => x.Amount)
            .GreaterThanOrEqualTo(0)
            .WithError(BudgetValidationErrors.AmountCannotBeNegative);
    }
}
