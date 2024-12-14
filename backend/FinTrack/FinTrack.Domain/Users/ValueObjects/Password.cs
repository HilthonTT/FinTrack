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

        if (!ContainUppercase(password))
        {
            return Result.Failure<Password>(PasswordErrors.MissingUppercase);
        }

        if (!ContainLowercase(password))
        {
            return Result.Failure<Password>(PasswordErrors.MissingLowercase);
        }

        if (!ContainNumber(password))
        {
            return Result.Failure<Password>(PasswordErrors.MissingNumber);
        }

        if (!ContainSpecialCharacter(password))
        {
            return Result.Failure<Password>(PasswordErrors.MissingSpecialCharacter);
        }

        return new Password(password);
    }

    public static bool ContainUppercase(string password) => password.Any(char.IsUpper);

    public static bool ContainLowercase(string password) => password.Any(char.IsLower);

    public static bool ContainNumber(string password) => password.Any(char.IsDigit);

    public static bool ContainSpecialCharacter(string password) =>
        password.Any(ch => !char.IsLetterOrDigit(ch));

    public static implicit operator string(Password password) => password.Value;
}
