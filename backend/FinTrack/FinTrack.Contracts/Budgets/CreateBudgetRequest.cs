using FinTrack.Domain.Budget.Enums;

namespace FinTrack.Contracts.Budgets;

public sealed record CreateBudgetRequest(
    Guid UserId, 
    string Name,
    BudgetType Type,
    decimal Amount, 
    string CurrencyCode, 
    DateOnly StartDate, 
    DateOnly EndDate);
