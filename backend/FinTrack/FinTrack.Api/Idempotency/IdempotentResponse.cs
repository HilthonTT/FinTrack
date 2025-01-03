using System.Text.Json.Serialization;

namespace FinTrack.Api.Idempotency;

internal sealed class IdempotentResponse
{
    [JsonConstructor]
    public IdempotentResponse(int statusCode, object? value)
    {
        StatusCode = statusCode;
        Value = value;
    }

    public int StatusCode { get; }

    public object? Value { get; }
}