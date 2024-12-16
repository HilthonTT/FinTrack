namespace FinTrack.Contracts.Budgets;

public sealed record BudgetResponse(
    Guid Id, 
    Guid UserId, 
    decimal Amount, 
    string AmountCurrency, 
    decimal Spent, 
    string SpentCurrency,
    DateOnly StartDate,
    DateOnly EndDate,
    DateTime CreatedOnUtc,
    DateTime? ModifiedOnUtc);
