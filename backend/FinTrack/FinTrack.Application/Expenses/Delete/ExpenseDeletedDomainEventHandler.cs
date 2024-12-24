using FinTrack.Application.Abstractions.Events;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Expenses.Events;

namespace FinTrack.Application.Expenses.Delete;

internal sealed class ExpenseDeletedDomainEventHandler(IEventBus eventBus)
    : IDomainEventHandler<ExpenseDeletedDomainEvent>
{
    public async Task Handle(ExpenseDeletedDomainEvent notification, CancellationToken cancellationToken)
    {
        var integrationEvent = new ExpenseDeletedIntegrationEvent(Guid.NewGuid(), notification.ExpenseId);

        await eventBus.PublishAsync(integrationEvent, cancellationToken);
    }
}
