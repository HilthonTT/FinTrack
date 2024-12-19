using FinTrack.Application.Abstractions.Events;
using FinTrack.Events.Bus;
using FinTrack.Events.Expenses;
using FinTrack.Events.Users.Created;
using MassTransit;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using SharedKernel;

namespace FinTrack.Events;

public static class DependencyInjection
{
    public static IServiceCollection AddEvents(this IServiceCollection services, IConfiguration configuration)
    {
        string? mqConnectionString = configuration.GetConnectionString("fintrack-mq");
        Ensure.NotNullOrWhitespace(mqConnectionString, nameof(mqConnectionString));

        services.AddMassTransit(busConfigurator =>
        {
            busConfigurator.SetKebabCaseEndpointNameFormatter();

            busConfigurator.AddConsumer<UserCreatedIntegrationEventHandler>();

            busConfigurator.AddConsumer<ExpenseAmountChangedIntegrationEventHandler>();

            busConfigurator.UsingRabbitMq((context, configurator) =>
            {
                configurator.Host(mqConnectionString);

                configurator.ReceiveEndpoint(nameof(UserCreatedIntegrationEventHandler), e =>
                {
                    e.ConfigureConsumer<UserCreatedIntegrationEventHandler>(context);
                });

                configurator.ReceiveEndpoint(nameof(ExpenseAmountChangedIntegrationEventHandler), e =>
                {
                    e.ConfigureConsumer<ExpenseAmountChangedIntegrationEventHandler>(context);
                });

                configurator.ConfigureEndpoints(context);
            });
        });

        services.AddTransient<IEventBus, EventBus>();

        return services;
    }
}
