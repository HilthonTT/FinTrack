using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Expenses;

namespace FinTrack.Application.Expenses.Update;

public sealed record UpdateExpenseCommand(
    Guid ExpenseId, 
    string Name, 
    decimal Amount,
    SubscriptionType SubscriptionType,
    ExpenseCategory ExpenseCategory,
    TransactionType TransactionType,
    DateTime Date) : ICommand;
