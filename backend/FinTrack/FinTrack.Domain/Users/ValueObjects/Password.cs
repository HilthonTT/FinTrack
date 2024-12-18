using SharedKernel;

namespace FinTrack.Domain.Users.ValueObjects;

public sealed record Password
{
    public const int MinimumPasswordLength = 6;

    public static readonly Func<char, bool> IsLower = c => c >= 'a' && c <= 'z';

    public static readonly Func<char, bool> IsUpper = c => c >= 'A' && c <= 'Z';

    public static readonly Func<char, bool> IsDigit = c => c >= '0' && c <= '9';

    public static readonly Func<char, bool> IsNonAlphaNumeric = c => !(IsLower(c) || IsUpper(c) || IsDigit(c));

    private Password(string value)
    {
        Value = value;
    }

    public string Value { get; }

    public static Result<Password> Create(string? password)
    {
        if (string.IsNullOrWhiteSpace(password))
        {
            return Result.Failure<Password>(PasswordErrors.Empty);
        }

        if (password.Length < MinimumPasswordLength)
        {
            return Result.Failure<Password>(PasswordErrors.TooShort);
        }

        if (!password.Any(p => IsLower(p)))
        {
            return Result.Failure<Password>(PasswordErrors.MissingLowercaseLetter);
        }

        if (!password.Any(p => IsUpper(p)))
        {
            return Result.Failure<Password>(PasswordErrors.MissingUppercaseLetter);
        }

        if (!password.Any(p => IsDigit(p)))
        {
            return Result.Failure<Password>(PasswordErrors.MissingDigit);
        }

        if (!password.Any(p => IsNonAlphaNumeric(p)))
        {
            return Result.Failure<Password>(PasswordErrors.MissingNonAlphaNumeric);
        }

        return new Password(password);
    }

    public static implicit operator string(Password password) => password.Value;
}
