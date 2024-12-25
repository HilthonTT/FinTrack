using FinTrack.Application.Core.Extensions;
using FluentValidation;

namespace FinTrack.Application.Subscriptions.Create;

internal sealed class CreateSubscriptionCommandValidator : AbstractValidator<CreateSubscriptionCommand>
{
    public CreateSubscriptionCommandValidator()
    {
        RuleFor(x => x.UserId)
            .NotEmpty()
            .WithError(SubscriptionValidationErrors.UserIdEmpty);

        RuleFor(x => x.Name)
            .NotEmpty()
            .WithError(SubscriptionValidationErrors.NameEmpty)
            .MaximumLength(256)
            .WithError(SubscriptionValidationErrors.NameTooLong);

        RuleFor(x => x.Amount)
            .NotEmpty()
            .WithError(SubscriptionValidationErrors.AmountEmpty);

        RuleFor(x => x.Currency)
            .NotEmpty()
            .WithError(SubscriptionValidationErrors.CurrencyCodeEmpty);

        RuleFor(x => x.Frequency)
            .NotEmpty()
            .WithError(SubscriptionValidationErrors.InvalidFrequency)
            .Must(value => Enum.IsDefined(value))
            .WithError(SubscriptionValidationErrors.InvalidFrequency);

        RuleFor(x => x.Company)
            .NotEmpty()
            .WithError(SubscriptionValidationErrors.InvalidCompany)
            .Must(value => Enum.IsDefined(value))
            .WithError(SubscriptionValidationErrors.InvalidCompany);
    }
}
