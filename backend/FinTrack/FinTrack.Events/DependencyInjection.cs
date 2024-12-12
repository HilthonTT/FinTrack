using FinTrack.Application.Abstractions.Events;
using FinTrack.Events.Bus;
using MassTransit;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using SharedKernel;

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
                string? connectionString = configuration.GetConnectionString("fintrack-mq");
                Ensure.NotNullOrWhitespace(connectionString, nameof(connectionString));

                configurator.Host(connectionString);

                configurator.ConfigureEndpoints(context);
            });
        });

        services.AddScoped<IEventBus, EventBus>();

        return services;
    }
}
