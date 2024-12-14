using SharedKernel;

namespace FinTrack.Domain.Expenses;

public static class ExpenseErrors
{
    public static readonly Error NameEmpty = Error.Problem(
        "ExpenseErrors.NameEmpty", "The name is empty");

    public static readonly Error AmountIsNegative = Error.Problem(
        "ExpenseErrors.AmountIsNegative", "The amount cannot be negative");
}
