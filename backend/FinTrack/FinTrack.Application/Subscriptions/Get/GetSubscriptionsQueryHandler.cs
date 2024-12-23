﻿using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Data;
using FinTrack.Application.Abstractions.Messaging;
using FinTrack.Contracts.Subscriptions;
using FinTrack.Domain.Subscriptions;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace FinTrack.Application.Subscriptions.Get;

internal sealed class GetSubscriptionsQueryHandler(
    IUserContext userContext,
    IDbContext dbContext) : IQueryHandler<GetSubscriptionsQuery, List<SubscriptionResponse>>
{
    public async Task<Result<List<SubscriptionResponse>>> Handle(
        GetSubscriptionsQuery request,
        CancellationToken cancellationToken)
    {
        IQueryable<Subscription> subscriptionsQuery = BuildSubscriptionsQuery(request);

        List<SubscriptionResponse> subscriptions = await GetSubscriptionResponsesAsync(subscriptionsQuery, cancellationToken);

        return subscriptions;
    }

    private IQueryable<Subscription> BuildSubscriptionsQuery(GetSubscriptionsQuery request)
    {
        IQueryable<Subscription> query = dbContext.Subscriptions.Where(s => s.UserId == userContext.UserId);

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

        query = query.Take(request.Take);

        return query;
    }

    private static async Task<List<SubscriptionResponse>> GetSubscriptionResponsesAsync(
        IQueryable<Subscription> query,
        CancellationToken cancellationToken)
    {
        return await query.Select(s => new SubscriptionResponse
        {
            Id = s.Id,
            UserId = s.UserId,
            Name = s.Name,
            Amount = s.Amount.Amount,
            Currency = s.Amount.Currency.Code,
            Frequency = s.Frequency,
            Company = s.Company,
            PeriodStart = s.SubscriptionPeriod.Start.ToDateTime(TimeOnly.MinValue),
            PeriodEnd = s.SubscriptionPeriod.End.ToDateTime(TimeOnly.MinValue),
            NextDueDate = s.NextDueDate.ToDateTime(TimeOnly.MinValue),
            Status = s.Status,
            CreatedOnUtc = s.CreatedOnUtc,
            ModifiedOnUtc = s.ModifiedOnUtc,
        }).ToListAsync(cancellationToken);
    }
}