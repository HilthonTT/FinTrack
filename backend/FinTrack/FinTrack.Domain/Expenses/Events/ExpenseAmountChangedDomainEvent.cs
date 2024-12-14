using FinTrack.Domain.Shared.ValueObjects;
using SharedKernel;

namespace FinTrack.Domain.Expenses.Events;

public sealed record ExpenseAmountChangedDomainEvent(Guid Id, Money Money) : IDomainEvent;
