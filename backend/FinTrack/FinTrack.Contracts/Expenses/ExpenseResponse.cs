using FinTrack.Domain.Expenses;
using FinTrack.Domain.Shared.Enums;

namespace FinTrack.Contracts.Expenses;

public sealed class ExpenseResponse
{
    public required Guid Id { get; set; }

    public required Guid UserId { get; set; }

    public required string Name { get; set; }

    public required decimal Amount { get; set; }

    public required string Currency { get; set; }

    public required ExpenseCategory Category { get; set; }

    public required Company Company { get; set; }

    public required DateTime Date { get; set; }

    public required DateTime CreatedOnUtc { get; set; }

    public required DateTime? ModifiedOnUtc { get; set; }
}
