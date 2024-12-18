using FinTrack.Application.Abstractions.Events;
using FinTrack.Domain.Shared.ValueObjects;

namespace FinTrack.Application.Expenses.Update;

public sealed record ExpenseAmountChangedIntegrationEvent(Guid Id, Guid ExpenseId, Money AmountDifference) 
    : IntegrationEvent(Id);
