using Microsoft.EntityFrameworkCore.ChangeTracking;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace FinTrack.Persistence.Interceptors;

internal sealed class UpdateAuditableInterceptor : SaveChangesInterceptor
{
    public override ValueTask<InterceptionResult<int>> SavingChangesAsync(
         DbContextEventData eventData,
         InterceptionResult<int> result,
         CancellationToken cancellationToken = default)
    {
        if (eventData.Context is not null)
        {
            UpdateAuditableEntities(eventData.Context);
        }

        return base.SavingChangesAsync(eventData, result, cancellationToken);
    }

    private static void UpdateAuditableEntities(DbContext context)
    {
        DateTime utcNow = DateTime.UtcNow;

        List<EntityEntry<IAuditable>> entities = context
            .ChangeTracker
            .Entries<IAuditable>()
            .ToList();

        foreach (EntityEntry<IAuditable> entry in entities)
        {
            if (entry.State == EntityState.Added)
            {
                entry.Property(e => e.CreatedOnUtc).CurrentValue = utcNow;
            }

            if (entry.State == EntityState.Modified)
            {
                entry.Property(e => e.ModifiedOnUtc).CurrentValue = utcNow;

            }
        }
    }
}
