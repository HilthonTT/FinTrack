﻿using SharedKernel;

namespace FinTrack.Domain.Subscriptions;

public static class SubscriptionErrors
{
    public static Error NotFound(Guid id) => Error.NotFound(
        "SubscriptionErrors.NotFound",
        $"The subscription with the Id = '{id}' was not found");

    public static readonly Error DueDateMustMatchPaymentDate = Error.Problem(
        "SubscriptionErrors.DueDateMustMatchPaymentDate",
        "The due date must match the payment date");

    public static readonly Error OnlyActiveSubscriptionsCanBeCanceled = Error.Problem(
        "SubscriptionErrors.OnlyActiveSubscriptionsCanBeCanceled",
        "Only active subscriptions can be canceled");

    public static readonly Error NameEmpty = Error.Problem(
        "SubscriptionErrors.NameEmpty",
        "The subscription name is empty");
}
