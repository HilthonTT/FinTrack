﻿using FinTrack.Application.Core.Extensions;
using FinTrack.Domain.Users.ValueObjects;
using FluentValidation;

namespace FinTrack.Application.Users.Register;

internal sealed class RegisterUserCommandValidator : AbstractValidator<RegisterUserCommand>
{
    public RegisterUserCommandValidator()
    {
        // Name validation
        RuleFor(x => x.Name)
            .NotEmpty().WithError(UserValidationErrors.NameEmpty)
            .MaximumLength(Name.MaxLength).WithError(UserValidationErrors.NameTooLong);

        // Email validation
        RuleFor(x => x.Email)
            .NotEmpty().WithError(UserValidationErrors.EmailEmpty)
            .EmailAddress().WithError(UserValidationErrors.EmailInvalidFormat);

        // Password validation
        RuleFor(x => x.Password)
            .NotEmpty().WithError(UserValidationErrors.PasswordEmpty)
            .MinimumLength(Password.MinimumLength).WithError(UserValidationErrors.PasswordTooShort)
            .Must(Password.ContainUppercase).WithError(UserValidationErrors.PasswordMissingUppercase)
            .Must(Password.ContainLowercase).WithError(UserValidationErrors.PasswordMissingLowercase)
            .Must(Password.ContainNumber).WithError(UserValidationErrors.PasswordMissingNumber)
            .Must(Password.ContainSpecialCharacter).WithError(UserValidationErrors.PasswordMissingSpecialCharacter);
    }
}
