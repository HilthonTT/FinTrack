using Microsoft.EntityFrameworkCore;

namespace FinTrack.Persistence;

public sealed class ApplicationDbContext(DbContextOptions options) : DbContext(options)
{
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(PersistenceAssembly.Instance);
    }
}
