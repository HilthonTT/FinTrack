namespace FinTrack.Contracts.Budgets;

public sealed record DepositBudgetRequest(Guid UserId, decimal Amount);
