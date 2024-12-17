using FinTrack.Application.Abstractions.Messaging;

namespace FinTrack.Application.Expenses.Update;

public sealed record UpdateExpenseCommand(
    Guid ExpenseId, 
    string Name, 
    decimal Amount,
    DateTime Date) : ICommand;
