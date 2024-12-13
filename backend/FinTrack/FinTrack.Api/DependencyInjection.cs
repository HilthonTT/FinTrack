using FinTrack.Api.Constants;
using FinTrack.Api.Extensions;
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

        return services;
    }
}
