using SharedKernel;

namespace FinTrack.Domain.Budget.Events;

public sealed record BudgetAmountDepositedDomainEvent(Guid BudgetId, decimal AmountDeposited) : IDomainEvent;
