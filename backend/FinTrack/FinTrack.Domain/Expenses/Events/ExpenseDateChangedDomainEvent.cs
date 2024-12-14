using SharedKernel;

namespace FinTrack.Domain.Expenses.Events;

public sealed record ExpenseDateChangedDomainEvent(Guid Id, DateTime Date) : IDomainEvent;
