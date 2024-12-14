using SharedKernel;

namespace FinTrack.Domain.Expenses.Events;

public sealed record ExpenseCreatedDomainEvent(Guid ExpenseId) : IDomainEvent;
