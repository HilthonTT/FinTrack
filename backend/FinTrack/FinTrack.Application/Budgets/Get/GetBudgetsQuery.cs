using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Budgets;
using FinTrack.Contracts.Common;

namespace FinTrack.Application.Budgets.Get;

public sealed record GetBudgetsQuery(string? SearchTerm, int PageSize) : IQuery<PagedList<BudgetResponse>>;
