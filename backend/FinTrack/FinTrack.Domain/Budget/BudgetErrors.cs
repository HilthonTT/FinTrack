using SharedKernel;

namespace FinTrack.Domain.Budget;

public static class BudgetErrors
{
    public static Error NotFound(Guid id) => Error.NotFound(
        "Budget.NotFound",
        $"The budget with the identifier = '{id}' was not found");

    public static Error NotFound(DateOnly startDate, DateOnly endDate) => Error.NotFound(
        "Budget.NotFound",
        $"No budget was found for the period from {startDate:MMMM d, yyyy} to {endDate:MMMM d, yyyy}.");

    public static readonly Error AmountMustBePositive = Error.Problem(
        "Budget.AmountMustBePositive",
        "The amount must be greater than zero");

    public static readonly Error ExceedsBudgetLimit = Error.Problem(
        "Budget.ExceedsBudgetLimit",
        "The withdrawal amount exceeds the available budget.");

    public static readonly Error ExceedsSpentAmount = Error.Problem(
        "Budget.ExceedsSpentAmount",
        "The deposit amount exceeds the spent amount.");
}
