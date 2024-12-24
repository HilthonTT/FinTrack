using FinTrack.Application.Abstractions.Events;

namespace FinTrack.Application.Expenses.Create;

public sealed record ExpenseCreatedIntegrationEvent(Guid Id, Guid ExpenseId) : IntegrationEvent(Id);
