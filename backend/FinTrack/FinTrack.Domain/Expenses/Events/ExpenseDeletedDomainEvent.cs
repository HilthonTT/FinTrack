using SharedKernel;

namespace FinTrack.Domain.Expenses.Events;

public sealed record ExpenseDeletedDomainEvent(Guid ExpenseId) : IDomainEvent;
