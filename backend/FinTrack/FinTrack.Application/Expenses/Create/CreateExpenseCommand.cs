using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Expenses;

namespace FinTrack.Application.Expenses.Create;

public sealed record CreateExpenseCommand(
    Guid UserId, 
    string Name, 
    decimal Amount, 
    string CurrencyCode, 
    ExpenseCategory ExpenseCategory,
    SubscriptionType SubscriptionType,
    TransactionType TransactionType,
    DateTime Date) : ICommand<Guid>;
