using FinTrack.Application.Abstractions.Events;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Expenses.Events;

namespace FinTrack.Application.Expenses.Update;

internal sealed class ExpenseAmountChangedDomainEventHandler(IEventBus eventBus)
    : IDomainEventHandler<ExpenseAmountChangedDomainEvent>
{
    public async Task Handle(ExpenseAmountChangedDomainEvent notification, CancellationToken cancellationToken)
    {
        var integrationEvent = new ExpenseAmountChangedIntegrationEvent(
            Guid.NewGuid(),
            notification.ExpenseId,
            notification.Money);

        await eventBus.PublishAsync(integrationEvent, cancellationToken);
    }
}
