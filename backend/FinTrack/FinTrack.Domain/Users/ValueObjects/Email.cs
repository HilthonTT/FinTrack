using SharedKernel;
using System.Text.RegularExpressions;

namespace FinTrack.Domain.Users.ValueObjects;

public sealed record Email
{
    public const int MaxLength = 256;

    private const string EmailRegexPattern =
        @"^(?!\.)(""([^""\r\\]|\\[""\r\\])*""|([-a-z0-9!#$%&'*+/=?^_`{|}~]|(?<!\.)\.)*)(?<!\.)@[a-z0-9][\w\.-]*[a-z0-9]\.[a-z][a-z\.]*[a-z]$";

    private Email(string value)
    {
        Value = value;
    }

    public string Value { get; init; }

    public static Result<Email> Create(string? email)
    {
        if (string.IsNullOrWhiteSpace(email))
        {
            return Result.Failure<Email>(EmailErrors.Empty);
        }

        if (email.Length > MaxLength)
        {
            return Result.Failure<Email>(EmailErrors.TooLong);
        }

        if (!Regex.IsMatch(email, EmailRegexPattern, RegexOptions.IgnoreCase))
        {
            return Result.Failure<Email>(EmailErrors.InvalidFormat);
        }

        return new Email(email);
    }

    public static implicit operator string(Email email) => email.Value;
}
