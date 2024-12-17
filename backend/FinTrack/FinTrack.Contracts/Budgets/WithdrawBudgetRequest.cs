namespace FinTrack.Contracts.Budgets;

public sealed record WithdrawBudgetRequest(Guid UserId, decimal Amount);
