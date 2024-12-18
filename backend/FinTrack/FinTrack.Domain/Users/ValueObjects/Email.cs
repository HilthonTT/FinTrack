using SharedKernel;
using System.Text.RegularExpressions;

namespace FinTrack.Domain.Users.ValueObjects;

public sealed record Email
{
    public const int MaxLength = 256;

    private const string EmailRegexPattern =
     @"^(?("")(""[^""]+?""@)|(([0-9a-z]((\.(?!\.))|[-!#\$%&'\*\+/=\?\^`\{\}\|~\w])*)[0-9a-z]@))" +
     @"(?(\[)(\[(\d{1,3}\.){3}\d{1,3}\])|(([0-9a-z][-0-9a-z]*[0-9a-z]*\.)+[a-z0-9]{2,24}))$";

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
