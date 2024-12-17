namespace FinTrack.Contracts.Expenses;

public sealed record UpdateExpenseRequest(string Name, decimal Amount, DateTime Date);
