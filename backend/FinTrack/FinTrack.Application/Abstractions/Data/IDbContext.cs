using FinTrack.Domain.Expenses;
using FinTrack.Domain.Subscriptions;
using Microsoft.EntityFrameworkCore;

namespace FinTrack.Application.Abstractions.Data;

public interface IDbContext
{
    DbSet<Subscription> Subscriptions { get; }

    DbSet<Expense> Expenses { get; }
}
