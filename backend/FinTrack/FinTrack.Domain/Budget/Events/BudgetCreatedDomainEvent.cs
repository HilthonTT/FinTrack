using SharedKernel;

namespace FinTrack.Domain.Budget.Events;

public sealed record BudgetCreatedDomainEvent(Guid BudgetId) : IDomainEvent;
