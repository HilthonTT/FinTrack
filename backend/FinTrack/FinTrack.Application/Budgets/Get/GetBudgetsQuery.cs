using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Budgets;

namespace FinTrack.Application.Budgets.Get;

public sealed record GetBudgetsQuery(string? SearchTerm, int Take) : IQuery<List<BudgetResponse>>;
