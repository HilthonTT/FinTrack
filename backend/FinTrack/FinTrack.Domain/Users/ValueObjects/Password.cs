using System.Text.RegularExpressions;
using SharedKernel;

namespace FinTrack.Domain.Users.ValueObjects;

public sealed record Password
{
    public const int MinimumLength = 6;

    private Password(string value)
    {
        Value = value;
    }

    public string Value { get; init; }

    public static Result<Password> Create(string? password)
    {
        if (string.IsNullOrWhiteSpace(password))
        {
            return Result.Failure<Password>(PasswordErrors.Empty);
        }

        if (password.Length < MinimumLength)
        {
            return Result.Failure<Password>(PasswordErrors.TooShort);
        }

        if (!Regex.IsMatch(password, @"[A-Z]"))
        {
            return Result.Failure<Password>(PasswordErrors.MissingUppercase);
        }

        if (!Regex.IsMatch(password, @"[a-z]"))
        {
            return Result.Failure<Password>(PasswordErrors.MissingLowercase);
        }

        if (!Regex.IsMatch(password, @"\d"))
        {
            return Result.Failure<Password>(PasswordErrors.MissingNumber);
        }

        if (!Regex.IsMatch(password, @"[\W_]"))
        {
            return Result.Failure<Password>(PasswordErrors.MissingSpecialCharacter);
        }

        return new Password(password);
    }

    public static implicit operator string(Password password) => password.Value;
}
