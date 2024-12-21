using FinTrack.Application.Core.Extensions;
using FluentValidation;

namespace FinTrack.Application.Subscriptions.Cancel;

internal sealed class CancelSubscriptionCommandValidator : AbstractValidator<CancelSubscriptionCommand>
{
    public CancelSubscriptionCommandValidator()
    {
        RuleFor(x => x.SubscriptionId)
            .NotEmpty()
            .WithError(SubscriptionValidationErrors.SubscriptionIdEmpty);
    }
}
