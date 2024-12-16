using FinTrack.Application.Core.Extensions;
using FluentValidation;

namespace FinTrack.Application.Budgets.Withdraw;

internal sealed class WithdrawBudgetCommandValidator : AbstractValidator<WithdrawBudgetCommand>
{
    public WithdrawBudgetCommandValidator()
    {
        RuleFor(x => x.UserId).NotEmpty().WithError(BudgetValidationErrors.UserIdEmpty);

        RuleFor(x => x.BudgetId).NotEmpty().WithError(BudgetValidationErrors.BudgetIdEmpty);

        RuleFor(x => x.Amount)
            .GreaterThanOrEqualTo(0)
            .WithError(BudgetValidationErrors.AmountCannotBeNegative);
    }
}
