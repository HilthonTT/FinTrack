using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Budgets;

namespace FinTrack.Application.Budgets.GetById;

public sealed record GetBudgetByIdQuery(Guid BudgetId) : IQuery<BudgetResponse>;
