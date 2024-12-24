using FinTrack.Application.Abstractions.Events;

namespace FinTrack.Application.Expenses.Update;

public sealed record ExpenseUpdatedIntegrationEvent(Guid Id, Guid ExpenseId) : IntegrationEvent(Id);
