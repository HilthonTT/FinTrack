﻿using FinTrack.Application.Core.Extensions;
using FluentValidation;

namespace FinTrack.Application.Users.VerifyEmail;

internal sealed class VerifyEmailCommandValidator : AbstractValidator<VerifyEmailCommand>
{
    public VerifyEmailCommandValidator()
    {
        RuleFor(x => x.TokenId).NotEmpty().WithError(UserValidationErrors.TokenIdEmpty);
    }
}