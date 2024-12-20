namespace FinTrack.Contracts.Expenses;

public sealed record ExpenseResponse(
    Guid Id, 
    Guid UserId, 
    string Name, 
    decimal Amount, 
    string CurrencyCode,
    int Category,
    int Company,
    DateTime Date,
    DateTime CreatedOnUtc,
    DateTime? ModifiedOnUtc);
