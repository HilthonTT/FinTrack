using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Common;
using FinTrack.Contracts.Expenses;
using FinTrack.Domain.Expenses;
using Microsoft.EntityFrameworkCore;
using SharedKernel;
using System.Data;

namespace FinTrack.Application.Expenses.Get;

internal sealed class GetExpensesQueryHandler(
    IUserContext userContext,
    IDbContext dbContext) : IQueryHandler<GetExpensesQuery, PagedList<ExpenseResponse>>
{
    public async Task<Result<PagedList<ExpenseResponse>>> Handle(GetExpensesQuery request, CancellationToken cancellationToken)
    {
        IQueryable<Expense> query = BuildExpensesQuery(request);

        PagedList<ExpenseResponse> expenses = await GetExpenseResponsesAsync(
            request, 
            query, 
            cancellationToken);

        return expenses;
    }

    private IQueryable<Expense> BuildExpensesQuery(GetExpensesQuery request)
    {
        IQueryable<Expense> query = dbContext.Expenses.Where(e => e.UserId == userContext.UserId);

        if (!string.IsNullOrWhiteSpace(request.SearchTerm))
        {
            query = query
                .Where(s => EF.Functions.ToTsVector("english", s.Name).Matches(EF.Functions.PhraseToTsQuery("english", request.SearchTerm)))
                .Select(s => new
                {
                    Subscription = s,
                    Rank = EF.Functions.ToTsVector("english", s.Name).Rank(EF.Functions.PhraseToTsQuery("english", request.SearchTerm))
                })
                .OrderByDescending(x => x.Rank)
                .Select(x => x.Subscription);
        }

        return query;
    }

    private static async Task<PagedList<ExpenseResponse>> GetExpenseResponsesAsync(
        GetExpensesQuery request,
        IQueryable<Expense> query,
        CancellationToken cancellationToken)
    {
        var expenseResponsesQuery = query.Select(s => new ExpenseResponse
        {
            Id = s.Id,
            UserId = s.UserId,
            Name = s.Name,
            Amount = s.Money.Amount,
            Currency = s.Money.Currency.Code,
            Category = s.Category,
            Company = s.Company,
            Date = s.Date,
            CreatedOnUtc = s.CreatedOnUtc,
            ModifiedOnUtc = s.ModifiedOnUtc,
        });

        PagedList<ExpenseResponse> expenses = await PagedList<ExpenseResponse>.CreateAsync(
            expenseResponsesQuery, 
            request.PageSize, 
            cancellationToken);

        return expenses;
    }
}
