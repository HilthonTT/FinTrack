namespace FinTrack.Contracts.Expenses;

public sealed record CreateExpenseRequest(
    Guid UserId, 
    string Name, 
    decimal Amount, 
    string CurrencyCode, 
    int ExpenseCategory,
    int Company,
    DateTime Date);
