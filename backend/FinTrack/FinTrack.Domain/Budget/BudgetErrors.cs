using SharedKernel;

namespace FinTrack.Domain.Budget;

public static class BudgetErrors
{
    public static readonly Error AmountMustBePositive = Error.Problem(
        "BudgetErrors.AmountMustBePositive",
        "The amount must be greater than zero");

    public static readonly Error ExceedsBudgetLimit = Error.Problem(
        "BudgetErrors.ExceedsBudgetLimit",
        "The withdrawal amount exceeds the available budget.");

    public static readonly Error ExceedsSpentAmount = Error.Problem(
        "BudgetErrors.ExceedsSpentAmount",
        "The deposit amount exceeds the spent amount.");
}
