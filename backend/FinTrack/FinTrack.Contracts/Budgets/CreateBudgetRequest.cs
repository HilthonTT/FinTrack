namespace FinTrack.Contracts.Budgets;

public sealed record CreateBudgetRequest(
    Guid UserId, 
    decimal Amount, 
    string CurrencyCode, 
    DateOnly StartDate, 
    DateOnly EndDate);
