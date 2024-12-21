using SharedKernel;

namespace FinTrack.Application.Subscriptions;

internal static class SubscriptionValidationErrors
{
    public static readonly Error SubscriptionIdEmpty = Error.Problem(
        "SubscriptionValidationErrors.SubscriptionIdEmpty",
        "The subscription identifier is empty");

    public static readonly Error UserIdEmpty = Error.Problem(
        "SubscriptionValidationErrors.UserIdEmpty",
        "The user identifier is empty");

    public static readonly Error NameEmpty = Error.Problem(
        "SubscriptionValidationErrors.NameEmpty",
        "The name is empty");

    public static readonly Error NameTooLong = Error.Problem(
        "SubscriptionValidationErrors.NameTooLong",
        "The name is too long");

    public static readonly Error AmountEmpty = Error.Problem(
        "SubscriptionValidationErrors.AmountEmpty",
        "The amount code is empty");

    public static readonly Error CurrencyCodeEmpty = Error.Problem(
        "SubscriptionValidationErrors.CurrencyCodeEmpty",
        "The currency code is empty");

    public static readonly Error StartDateEmpty = Error.Problem(
        "SubscriptionValidationErrors.StartDateEmpty",
        "The start date is empty");

    public static readonly Error EndDateEmpty = Error.Problem(
       "SubscriptionValidationErrors.EndDateEmpty",
       "The end date is empty");

    public static readonly Error InvalidCompany = Error.Problem(
        "SubscriptionValidationErrors.InvalidCompany",
        "The company is invalid");

    public static readonly Error InvalidFrequency = Error.Problem(
       "SubscriptionValidationErrors.InvalidFrequency",
       "The frequency is invalid");
}
