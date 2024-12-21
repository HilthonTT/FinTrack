using FinTrack.Application.Core.Extensions;
using FluentValidation;

namespace FinTrack.Application.Subscriptions.Update;

internal sealed class UpdateSubscriptionCommandValidator : AbstractValidator<UpdateSubscriptionCommand>
{
    public UpdateSubscriptionCommandValidator()
    {
        RuleFor(x => x.SubscriptionId)
            .NotEmpty()
            .WithError(SubscriptionValidationErrors.SubscriptionIdEmpty);

        RuleFor(x => x.Name)
            .NotEmpty()
            .WithError(SubscriptionValidationErrors.NameEmpty)
            .MaximumLength(256)
            .WithError(SubscriptionValidationErrors.NameTooLong);

        RuleFor(x => x.Frequency)
            .NotEmpty()
            .WithError(SubscriptionValidationErrors.InvalidFrequency)
            .Must(Enum.IsDefined)
            .WithError(SubscriptionValidationErrors.InvalidFrequency);

        RuleFor(x => x.Company)
           .NotEmpty()
           .WithError(SubscriptionValidationErrors.InvalidCompany)
           .Must(Enum.IsDefined)
           .WithError(SubscriptionValidationErrors.InvalidCompany);
    }
}
