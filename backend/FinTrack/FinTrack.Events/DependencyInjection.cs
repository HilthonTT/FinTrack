using MassTransit;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace FinTrack.Events;

public static class DependencyInjection
{
    public static IServiceCollection AddEvents(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddMassTransit(busConfigurator =>
        {
            busConfigurator.SetKebabCaseEndpointNameFormatter();

            busConfigurator.UsingRabbitMq((context, configurator) =>
            {
                configurator.Host(configuration.GetConnectionString("fintrack-mq"));

                configurator.ConfigureEndpoints(context);
            });
        });

        return services;
    }
}
