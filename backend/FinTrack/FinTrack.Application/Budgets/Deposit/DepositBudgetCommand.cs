using FinTrack.Application.Abstractions.Messaging;

namespace FinTrack.Application.Budgets.Deposit;

public sealed record DepositBudgetCommand(Guid BudgetId, Guid UserId, decimal Amount) : ICommand;
