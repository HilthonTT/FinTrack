using SharedKernel;

namespace FinTrack.Application.Abstractions.Idempotency;

internal static class IdempotencyErrors
{
    public static readonly Error RequestAlreadyProcessed = Error.Conflict(
        "IdempotencyErrors.RequestAlreadyProcessed",
        "The request with this identifier has already been processed");
}
