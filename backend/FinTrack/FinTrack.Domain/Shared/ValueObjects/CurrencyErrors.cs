using SharedKernel;

namespace FinTrack.Domain.Shared.ValueObjects;

public static class CurrencyErrors
{
    public static Error NotFound(string code) => Error.NotFound(
        "Currency.NotFound",
        $"The currency with the code '{code}' was not found");
}
