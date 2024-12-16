using FinTrack.Application.Abstractions.Idempotency;

namespace FinTrack.Application.Budgets.Create;

public sealed record CreateBudgetCommand(
    Guid RequestId,
    Guid UserId,
    decimal Amount,
    string CurrencyCode,
    DateOnly StartDate,
    DateOnly EndDate) : IdempotentCommand<Guid>(RequestId);
