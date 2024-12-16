using FinTrack.Api.Constants;
using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using Microsoft.AspNetCore.Http.Features;
using System.Diagnostics;
using System.Reflection;
using System.Threading.RateLimiting;

namespace FinTrack.Api;

public static class DependencyInjection
{
    public static IServiceCollection AddPresentation(this IServiceCollection services)
    {
        services.AddEndpoints(Assembly.GetExecutingAssembly());

        services
            .AddServices()
            .ConfigureCors()
            .ConfigureProblemDetails()
            .ConfigureRateLimiter();

        return services;
    }

    private static IServiceCollection AddServices(this IServiceCollection services)
    {
        services.AddOpenApi();

        return services;
    }

    private static IServiceCollection ConfigureCors(this IServiceCollection services)
    {
        services.AddCors(options =>
        {
            options.AddPolicy(CorsPolicy.AllowAllHeaders,
                builder =>
                {
                    builder
                        .AllowAnyOrigin()
                        .AllowAnyHeader()
                        .AllowAnyMethod();
                });
        });

        return services;
    }

    private static IServiceCollection ConfigureProblemDetails(this IServiceCollection services)
    {
        services.AddProblemDetails(o =>
        {
            o.CustomizeProblemDetails = context =>
            {
                context.ProblemDetails.Instance = $"{context.HttpContext.Request.Method} {context.HttpContext.Request.Path}";

                Activity? activity = context.HttpContext.Features.Get<IHttpActivityFeature>()?.Activity;

                context.ProblemDetails.Extensions.TryAdd("requestId", context.HttpContext.TraceIdentifier);
                context.ProblemDetails.Extensions.TryAdd("traceId", activity?.Id);
            };
        });

        services.AddExceptionHandler<GlobalExceptionHandler>();

        return services;
    }

    private static IServiceCollection ConfigureRateLimiter(this IServiceCollection services)
    {
        services.AddRateLimiter(rateLimiterOptions =>
        {
            rateLimiterOptions.RejectionStatusCode = StatusCodes.Status429TooManyRequests;

            rateLimiterOptions.AddPolicy(RateLimitPolicy.FixedByIp, httpContext =>
                RateLimitPartition.GetFixedWindowLimiter(
                    httpContext.Connection.RemoteIpAddress?.ToString(),
                    _ => new FixedWindowRateLimiterOptions
                    {
                        PermitLimit = 50,
                        Window = TimeSpan.FromMinutes(1),
                    }));
        });

        return services;
    }
}
