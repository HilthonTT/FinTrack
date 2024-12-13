using SharedKernel;

namespace FinTrack.Domain.Users;

public static class EmailVerificationTokenErrors
{
    public static readonly Error CannotFindNonExpiredToken = Error.Problem(
        "EmailVerificationTokenErrors.CannotFindNonExpiredToken",
        "All of your email verification tokens are expired");
}
