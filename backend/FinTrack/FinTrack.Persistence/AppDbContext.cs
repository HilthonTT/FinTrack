using FinTrack.Application.Abstractions.Data;
using FinTrack.Domain.Users;
using FinTrack.Persistence.Outbox;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage;
using System.Data;

namespace FinTrack.Persistence;

public sealed class AppDbContext : DbContext, IUnitOfWork
{
    public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options)
    {
        
    }

    public DbSet<User> Users { get; set; }

    public DbSet<EmailVerificationToken> EmailVerificationTokens { get; set; }

    public DbSet<RefreshToken> RefreshTokens { get; set; }

    public DbSet<OutboxMessage> OutboxMessages { get; set; }

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
