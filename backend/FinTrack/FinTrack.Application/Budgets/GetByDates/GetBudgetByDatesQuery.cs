using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Budgets;

namespace FinTrack.Application.Budgets.GetByDates;

public sealed record GetBudgetByDatesQuery(
    Guid UserId, 
    DateOnly StartDate, 
    DateOnly EndDate) : IQuery<BudgetResponse>;
