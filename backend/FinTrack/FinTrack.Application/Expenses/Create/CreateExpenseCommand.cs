using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Domain.Expenses;
using FinTrack.Domain.Shared.Enums;

namespace FinTrack.Application.Expenses.Create;

public sealed record CreateExpenseCommand(
    Guid UserId, 
    string Name, 
    decimal Amount, 
    string CurrencyCode, 
    ExpenseCategory Category,
    Company Company,
    DateTime Date) : ICommand<Guid>;
