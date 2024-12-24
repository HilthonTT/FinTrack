using FinTrack.Application.Abstractions.Events;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Expenses.Events;

namespace FinTrack.Application.Expenses.Create;

internal sealed class ExpenseCreatedDomainEventHandler(IEventBus eventBus) 
    : IDomainEventHandler<ExpenseCreatedDomainEvent>
{
    public async Task Handle(ExpenseCreatedDomainEvent notification, CancellationToken cancellationToken)
    {
        var integrationEvent = new ExpenseCreatedIntegrationEvent(Guid.NewGuid(), notification.ExpenseId);

        await eventBus.PublishAsync(integrationEvent, cancellationToken);
    }
}
