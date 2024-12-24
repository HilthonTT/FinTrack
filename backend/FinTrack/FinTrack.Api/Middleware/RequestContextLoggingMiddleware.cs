using Microsoft.Extensions.Primitives;
using OpenTelemetry.Trace;

namespace FinTrack.Api.Middleware;

internal sealed class RequestContextLoggingMiddleware
{
    private const string CorrelationIdHeaderName = "Correlation-Id";

    private readonly RequestDelegate _next;
    private readonly Tracer _tracer;

    public RequestContextLoggingMiddleware(RequestDelegate next, TracerProvider tracerProvider)
    {
        _next = next;
        _tracer = tracerProvider.GetTracer("FinTrack.Api");
    }

    public async Task Invoke(HttpContext context)
    {
        string correlationId = GetCorrelationId(context);

        using TelemetrySpan span = _tracer.StartActiveSpan("HTTP Request", SpanKind.Server);

        span.SetAttribute("http.request.correlation_id", correlationId);

        await _next.Invoke(context);

        span.SetAttribute("http.response.status_code", context.Response.StatusCode);
    }

    private static string GetCorrelationId(HttpContext context)
    {
        context.Request.Headers.TryGetValue(
            CorrelationIdHeaderName, 
            out StringValues correlationId);

        return correlationId.FirstOrDefault() ?? context.TraceIdentifier;
    }
}