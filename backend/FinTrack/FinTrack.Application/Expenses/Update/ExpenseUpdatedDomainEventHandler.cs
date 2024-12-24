using FinTrack.Application.Abstractions.Events;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Expenses.Events;

namespace FinTrack.Application.Expenses.Update;

internal sealed class ExpenseUpdatedDomainEventHandler(IEventBus eventBus) 
    : IDomainEventHandler<ExpenseUpdatedDomainEvent>
{
    public async Task Handle(ExpenseUpdatedDomainEvent notification, CancellationToken cancellationToken)
    {
        var integrationEvent = new ExpenseUpdatedIntegrationEvent(Guid.NewGuid(), notification.ExpenseId);

        await eventBus.PublishAsync(integrationEvent, cancellationToken);
    }
}
