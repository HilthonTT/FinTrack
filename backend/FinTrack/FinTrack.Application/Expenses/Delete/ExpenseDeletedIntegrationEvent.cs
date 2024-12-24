using FinTrack.Application.Abstractions.Events;

namespace FinTrack.Application.Expenses.Delete;

public sealed record ExpenseDeletedIntegrationEvent(Guid Id, Guid ExpenseId) : IntegrationEvent(Id);
