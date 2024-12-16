using SharedKernel;

namespace FinTrack.Application.Budgets;

internal static class BudgetValidationErrors
{
    public static readonly Error BudgetIdEmpty = Error.Problem(
       "BudgetValidation.BudgetIdEmpty",
       "The budget identifier is empty");

    public static readonly Error UserIdEmpty = Error.Problem(
        "BudgetValidation.UserIdEmpty",
        "The user identifier is empty");

    public static readonly Error AmountCannotBeNegative = Error.Problem(
        "BudgetValidation.AmountCannotBeNegative",
        "The amount cannot be a negative number");

    public static readonly Error CurrencyCodeEmpty = Error.Problem(
        "BudgetValidation.CurrencyCodeEmpty",
        "The currency code is empty");

    public static readonly Error CurrencyCodeInvalid = Error.Problem(
        "BudgetValidation.CurrencyCodeInvalid",
        "The currency code is invalid");

    public static readonly Error StartDateInPast = Error.Problem(
        "BudgetValidation.StartDateInPast",
        "The start date cannot be in the past");

    public static readonly Error EndDateBeforeStartDate = Error.Problem(
        "BudgetValidation.EndDateBeforeStartDate",
        "The end date cannot be earlier than the start date");
}
