using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Primitives;
using System.Text.Json;

namespace FinTrack.Api.Idempotency;

internal sealed class IdempotencyFilter : IEndpointFilter
{
    private const int CacheTimeInMinutes = 60;

    public async ValueTask<object?> InvokeAsync(EndpointFilterInvocationContext context, EndpointFilterDelegate next)
    {
        if (!TryGetIdempotenceKey(context.HttpContext, out Guid idempotenceKey))
        {
            return Results.BadRequest("Invalid or missing Idempotence-Key header");
        }

        IDistributedCache cache = context.HttpContext
           .RequestServices.GetRequiredService<IDistributedCache>();

        // Check if we already processed this request and return a cached response (if it exists)
        string cacheKey = $"Idempotent_{idempotenceKey}";
        string? cachedResult = await cache.GetStringAsync(cacheKey);
        if (cachedResult is not null)
        {
            IdempotentResponse response = JsonSerializer.Deserialize<IdempotentResponse>(cachedResult)!;
            return new IdempotentResult(response.StatusCode, response.Value);
        }

        object? result = await next(context);

        // Execute the request and cache the response for the specified duration
        if (result is IStatusCodeHttpResult { StatusCode: >= 200 and < 300 } statusCodeResult
            and IValueHttpResult valueResult)
        {
            int statusCode = statusCodeResult.StatusCode ?? StatusCodes.Status200OK;
            IdempotentResponse response = new(statusCode, valueResult.Value);

            await cache.SetStringAsync(
                cacheKey,
                JsonSerializer.Serialize(response),
                new DistributedCacheEntryOptions
                {
                    AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(CacheTimeInMinutes)
                }
            );
        }

        return result;
    }

    private static bool TryGetIdempotenceKey(HttpContext context, out Guid idempotenceKey)
    {
        idempotenceKey = Guid.Empty;

        if (context.Request.Headers.TryGetValue("Idempotence-Key", out StringValues idempotenceKeyValue))
        {
            return Guid.TryParse(idempotenceKeyValue, out idempotenceKey);
        }

        return false;
    }
}
