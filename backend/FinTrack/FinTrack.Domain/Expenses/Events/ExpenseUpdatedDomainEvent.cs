using SharedKernel;

namespace FinTrack.Domain.Expenses.Events;

public sealed record ExpenseUpdatedDomainEvent(Guid ExpenseId) : IDomainEvent;
