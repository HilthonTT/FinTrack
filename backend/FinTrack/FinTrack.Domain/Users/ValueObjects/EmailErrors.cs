using SharedKernel;

namespace FinTrack.Domain.Users.ValueObjects;

public static class EmailErrors
{
    public static readonly Error Empty = Error.Problem("Email.Empty", "The email is empty");

    public static readonly Error InvalidFormat = Error.Problem("Email.InvalidFormat", "The email format is invalid");

    public static readonly Error TooLong = Error.Problem("Email.TooLong", "The email is too long");
}
