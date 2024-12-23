using FinTrack.Domain.Budget.Enums;

namespace FinTrack.Contracts.Budgets;

public sealed class BudgetResponse
{
    public required Guid Id { get; set; }

    public required Guid UserId { get; set; }

    public required string Name { get; set; }

    public required BudgetType Type { get; set; }

    public required decimal Amount { get; set; }

    public required string Currency { get; set; }

    public required decimal Spent { get; set; }

    public required decimal AmountLeft { get; set; }

    public required DateOnly StartDate { get; set; }

    public required DateOnly EndDate { get; set; }

    public required DateTime CreatedOnUtc { get; set; }

    public DateTime? ModifiedOnUtc { get; set; }
}