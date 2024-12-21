using FinTrack.Application.Core.Extensions;
using FluentValidation;

namespace FinTrack.Application.Subscriptions.Delete;

internal sealed class DeleteSubscriptionCommandValidator : AbstractValidator<DeleteSubscriptionCommand> 
{
    public DeleteSubscriptionCommandValidator()
    {
        RuleFor(x => x.SubscriptionId)
            .NotEmpty()
            .WithError(SubscriptionValidationErrors.SubscriptionIdEmpty);
    }
}
