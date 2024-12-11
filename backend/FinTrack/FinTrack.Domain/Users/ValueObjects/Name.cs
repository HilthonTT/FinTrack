using SharedKernel;

namespace FinTrack.Domain.Users.ValueObjects;

public sealed record Name
{
    public const int MaxLength = 256;

    private Name(string value)
    {
        Value = value;
    }

    public string Value { get; init; }

    public static Result<Name> Create(string? email)
    {
        if (string.IsNullOrWhiteSpace(email))
        {
            return Result.Failure<Name>(NameErrors.Empty);
        }

        if (email.Length > MaxLength)
        {
            return Result.Failure<Name>(NameErrors.TooLong);
        }

        return new Name(email);
    }
}
