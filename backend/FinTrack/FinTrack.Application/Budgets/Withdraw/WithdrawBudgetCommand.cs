using FinTrack.Application.Abstractions.Messaging;

namespace FinTrack.Application.Budgets.Withdraw;

public sealed record WithdrawBudgetCommand(Guid UserId, Guid BudgetId, decimal Amount) : ICommand;
