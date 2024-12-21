using FinTrack.Domain.Expenses;
using FinTrack.Domain.Shared.Enums;

namespace FinTrack.Contracts.Expenses;

public sealed record CreateExpenseRequest(
    Guid UserId, 
    string Name, 
    decimal Amount, 
    string CurrencyCode, 
    ExpenseCategory Category,
    Company Company,
    DateTime Date);
