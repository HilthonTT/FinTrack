using SharedKernel;

namespace FinTrack.Application.Expenses;

internal static class ExpenseValidationErrors
{
    public static readonly Error ExpenseIdEmpty = Error.Problem(
       "ExpenseValidationErrors.ExpenseIdEmpty",
       "The expense identifier is empty");

    public static readonly Error UserIdEmpty = Error.Problem(
        "ExpenseValidationErrors.UserIdEmpty",
        "The user identifier is empty");

    public static readonly Error NameEmpty = Error.Problem(
        "ExpenseValidationErrors.NameEmpty",
        "The name is empty");

    public static readonly Error NameTooLong = Error.Problem(
        "ExpenseValidationErrors.NameTooLong",
        "The name is too long");

    public static readonly Error CurrencyCodeEmpty = Error.Problem(
        "ExpenseValidationErrors.CurrencyCodeEmpty",
        "The currency code is empty");

    public static readonly Error DateEmpty = Error.Problem(
        "ExpenseValidationErrors.DateEmpty",
        "The date is empty");

    public static readonly Error InvalidExpenseCategory = Error.Problem(
        "ExpenseValidationErrors.InvalidExpenseCategory",
        "The expense category is invalid");

    public static readonly Error InvalidSubscriptionType = Error.Problem(
        "ExpenseValidationErrors.InvalidSubscriptionType",
        "The subscription type is invalid");

    public static readonly Error InvalidTransactionType = Error.Problem(
        "ExpenseValidationErrors.InvalidTransactionType",
        "The transaction type is invalid");
}
