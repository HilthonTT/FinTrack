using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Expenses;

namespace FinTrack.Application.Expenses.Get;

public sealed record GetExpensesQuery(string? SearchTerm, int Take) : IQuery<List<ExpenseResponse>>;
