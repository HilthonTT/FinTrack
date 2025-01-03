﻿using FinTrack.Application.Abstractions.Data;
using FinTrack.Domain.Budget;
using FinTrack.Domain.Expenses;
using FinTrack.Domain.Subscriptions;
using FinTrack.Domain.Users;
using FinTrack.Persistence.Idempotency;
using FinTrack.Persistence.Outbox;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage;
using System.Data;

namespace FinTrack.Persistence.Context;

public sealed class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options), IUnitOfWork, IDbContext
{
    public DbSet<User> Users { get; set; }

    public DbSet<EmailVerificationToken> EmailVerificationTokens { get; set; }

    public DbSet<RefreshToken> RefreshTokens { get; set; }

    public DbSet<OutboxMessage> OutboxMessages { get; set; }

    public DbSet<IdempotentRequest> IdempotentRequests { get; set; }

    public DbSet<Budget> Budgets { get; set; }

    public DbSet<Expense> Expenses { get; set; }

    public DbSet<Subscription> Subscriptions { get; set; }

    public DbContext Context => this;

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(PersistenceAssembly.Instance);

        base.OnModelCreating(modelBuilder);
    }

    public async Task<IDbTransaction> BeginTransactionAsync(CancellationToken cancellationToken = default)
    {
        return (await Database.BeginTransactionAsync(cancellationToken)).GetDbTransaction();
    }
}
