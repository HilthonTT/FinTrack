using SharedKernel;

namespace FinTrack.Domain.Budget.Events;

public sealed record BudgetAmountWithdrawnDomainEvent(Guid BudgetId, decimal AmountWithdrawn) : IDomainEvent;
