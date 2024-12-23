using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Budgets;
using FinTrack.Domain.Budget;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace FinTrack.Application.Budgets.Get;

internal sealed class GetBudgetsQueryHandler(
    IUserContext userContext,
    IDbContext dbContext) : IQueryHandler<GetBudgetsQuery, List<BudgetResponse>>
{
    public async Task<Result<List<BudgetResponse>>> Handle(GetBudgetsQuery request, CancellationToken cancellationToken)
    {
        IQueryable<Budget> query = BuildBudgetsQuery(request);

        List<BudgetResponse> budgets = await GetBudgetResponsesAsync(query, cancellationToken);

        return budgets;
    }

    private IQueryable<Budget> BuildBudgetsQuery(GetBudgetsQuery request)
    {
        IQueryable<Budget> query = dbContext.Budgets.Where(e => e.UserId == userContext.UserId);

        if (!string.IsNullOrWhiteSpace(request.SearchTerm))
        {
            query = query
                .Where(s => EF.Functions.ToTsVector("english", s.Name).Matches(EF.Functions.PhraseToTsQuery("english", request.SearchTerm)))
                .Select(s => new
                {
                    Budget = s,
                    Rank = EF.Functions.ToTsVector("english", s.Name).Rank(EF.Functions.PhraseToTsQuery("english", request.SearchTerm))
                })
                .OrderByDescending(x => x.Rank)
                .Select(x => x.Budget);
        }

        query = query.Take(request.Take);

        return query;
    }

    private static async Task<List<BudgetResponse>> GetBudgetResponsesAsync(
        IQueryable<Budget> query,
        CancellationToken cancellationToken)
    {
        return await query.Select(b => new BudgetResponse
        {
            Id = b.Id,
            UserId = b.UserId,
            Name = b.Name,
            Type = b.Type,
            Amount = b.Amount.Amount,
            Currency = b.Amount.Currency.Code,
            Spent = b.Spent.Amount,
            Remaining = b.Remaining.Amount,
            StartDate = b.DateRange.Start,
            EndDate = b.DateRange.End,
            CreatedOnUtc = b.CreatedOnUtc,
            ModifiedOnUtc = b.ModifiedOnUtc
        })
        .ToListAsync(cancellationToken);
    }
}
