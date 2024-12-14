using SharedKernel;

namespace FinTrack.Domain.Expenses.Events;

public sealed record ExpenseRenamedDomainEvent(Guid ExpenseId, string Name) : IDomainEvent;
