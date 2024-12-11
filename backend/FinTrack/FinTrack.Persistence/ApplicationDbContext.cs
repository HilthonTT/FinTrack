using FinTrack.Domain.Users;
using Microsoft.EntityFrameworkCore;

namespace FinTrack.Persistence;

public sealed class ApplicationDbContext(DbContextOptions options) : DbContext(options)
{
    public required DbSet<User> Users { get; set; }

    public required DbSet<EmailVerificationToken> EmailVerificationTokens { get; set; }

    public required DbSet<RefreshToken> RefreshTokens { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(PersistenceAssembly.Instance);
        
        base.OnModelCreating(modelBuilder);
    }
}
