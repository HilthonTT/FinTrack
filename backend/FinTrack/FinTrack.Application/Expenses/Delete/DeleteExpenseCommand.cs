using FinTrack.Application.Abstractions.Messaging;

namespace FinTrack.Application.Expenses.Delete;

public sealed record DeleteExpenseCommand(Guid ExpenseId) : ICommand;
