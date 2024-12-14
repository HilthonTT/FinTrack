using SharedKernel;

namespace FinTrack.Domain.Users;

public static class RefreshTokenErrors
{
    public static readonly Error Expired = Error.Problem(
        "RefreshTokenErrors.Expired", "The refresh token has expired");
}
