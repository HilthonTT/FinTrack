using FinTrack.Api.Extensions;
using System.Reflection;

namespace FinTrack.Api;

public static class DependencyInjection
{
    public static IServiceCollection AddPresentation(this IServiceCollection services)
    {
        services.AddOpenApi();

        services.AddEndpoints(Assembly.GetExecutingAssembly());

        return services;
    }
}
