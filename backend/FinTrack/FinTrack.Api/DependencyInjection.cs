using FinTrack.Api.Constants;
using FinTrack.Api.Extensions;
using FinTrack.Api.Infrastructure;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.Features;
using System.Diagnostics;
using System.Reflection;

namespace FinTrack.Api;

public static class DependencyInjection
{
    public static IServiceCollection AddPresentation(this IServiceCollection services)
    {
        services.AddOpenApi();

        services.AddEndpoints(Assembly.GetExecutingAssembly());

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
}
