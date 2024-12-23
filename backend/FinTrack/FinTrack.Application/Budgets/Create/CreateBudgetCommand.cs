using FinTrack.Application.Abstractions.Idempotency;
using FinTrack.Domain.Budget.Enums;

namespace FinTrack.Application.Budgets.Create;

public sealed record CreateBudgetCommand(
    Guid RequestId,
    Guid UserId,
    string Name,
    BudgetType Type,
    decimal Amount,
    string CurrencyCode,
    DateOnly StartDate,
    DateOnly EndDate) : IdempotentCommand<Guid>(RequestId);
