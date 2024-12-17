using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Expenses;

namespace FinTrack.Application.Expenses.GetById;

public sealed record GetExpenseByIdQuery(Guid ExpenseId) : IQuery<ExpenseResponse>;
