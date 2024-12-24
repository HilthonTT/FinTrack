using FinTrack.Application.Abstractions.Events;
using FinTrack.Events.Bus;
using FinTrack.Events.Expenses.AmountChanged;
using FinTrack.Events.Expenses.Created;
using FinTrack.Events.Expenses.Deleted;
using FinTrack.Events.Expenses.Updated;
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

            busConfigurator.AddUserConsumers();
            busConfigurator.AddExpenseConsumers();

            busConfigurator.UsingRabbitMq((context, configurator) =>
            {
                configurator.Host(mqConnectionString);

                configurator.ReceiveUserEndpoints(context);

                configurator.ReceiveExpensesEndpoints(context);

                configurator.ConfigureEndpoints(context);
            });
        });

        services.AddTransient<IEventBus, EventBus>();

        return services;
    }

    private static IBusRegistrationConfigurator AddUserConsumers(this IBusRegistrationConfigurator busConfigurator)
    {
        busConfigurator.AddConsumer<UserCreatedIntegrationEventHandler>();

        return busConfigurator;
    }

    private static IBusRegistrationConfigurator AddExpenseConsumers(this IBusRegistrationConfigurator busConfigurator)
    {
        busConfigurator.AddConsumer<ExpenseAmountChangedIntegrationEventHandler>();
        busConfigurator.AddConsumer<ExpenseCreatedIntegrationEventHandler>();
        busConfigurator.AddConsumer<ExpenseDeletedIntegrationEventHandler>();
        busConfigurator.AddConsumer<ExpenseUpdatedIntegrationEventHandler>();

        return busConfigurator;
    }

    private static IRabbitMqBusFactoryConfigurator ReceiveUserEndpoints(
        this IRabbitMqBusFactoryConfigurator configurator,
        IBusRegistrationContext context)
    {
        configurator.ReceiveEndpoint(nameof(UserCreatedIntegrationEventHandler), e =>
        {
            e.ConfigureConsumer<UserCreatedIntegrationEventHandler>(context);
        });

        return configurator;
    }


    private static IRabbitMqBusFactoryConfigurator ReceiveExpensesEndpoints(
        this IRabbitMqBusFactoryConfigurator configurator,
        IBusRegistrationContext context)
    {
        configurator.ReceiveEndpoint(nameof(ExpenseAmountChangedIntegrationEventHandler), e =>
        {
            e.ConfigureConsumer<ExpenseAmountChangedIntegrationEventHandler>(context);
        });

        configurator.ReceiveEndpoint(nameof(ExpenseCreatedIntegrationEventHandler), e =>
        {
            e.ConfigureConsumer<ExpenseCreatedIntegrationEventHandler>(context);
        });

        configurator.ReceiveEndpoint(nameof(ExpenseDeletedIntegrationEventHandler), e =>
        {
            e.ConfigureConsumer<ExpenseDeletedIntegrationEventHandler>(context);
        });

        configurator.ReceiveEndpoint(nameof(ExpenseUpdatedIntegrationEventHandler), e =>
        {
            e.ConfigureConsumer<ExpenseUpdatedIntegrationEventHandler>(context);
        });

        return configurator;
    }
}
