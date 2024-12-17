namespace FinTrack.Contracts.Expenses;

public sealed record ExpenseResponse(
    Guid Id, 
    Guid UserId, 
    string Name, 
    decimal Amount, 
    string CurrencyCode,
    int Category,
    int SubscriptionType,
    int TransactionType,
    DateTime Date,
    DateTime CreatedOnUtc,
    DateTime? ModifiedOnUtc);
