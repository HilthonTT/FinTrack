using FinTrack.Application.Abstractions.Messaging;

namespace FinTrack.Application.Expenses.Create;

public sealed record CreateExpenseCommand(
    Guid UserId, 
    string Name, 
    decimal Amount, 
    string CurrencyCode, 
    int ExpenseCategory,
    int SubscriptionType,
    int TransactionType,
    DateTime Date) : ICommand<Guid>;
