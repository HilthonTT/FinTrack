using FinTrack.Domain.Shared.ValueObjects;
using SharedKernel;

namespace FinTrack.Domain.Expenses.Events;

public sealed record ExpenseAmountChangedDomainEvent(Guid ExpenseId, Money Money) : IDomainEvent;
