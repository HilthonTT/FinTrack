using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Logging;
using System.Text.Json;

namespace FinTrack.Persistence.Interceptors;

internal sealed class DebugInterceptor(ILogger<DebugInterceptor> logger) : SaveChangesInterceptor
{
    public override ValueTask<InterceptionResult<int>> SavingChangesAsync(
        DbContextEventData eventData,
        InterceptionResult<int> result,
        CancellationToken cancellationToken = default)
    {
        if (eventData.Context is not null)
        {
            LogEntities(eventData.Context);
        }

        return base.SavingChangesAsync(eventData, result, cancellationToken);
    }

    private void LogEntities(DbContext dbContext)
    {
        return;

        List<EntityEntry> trackedEntities = dbContext.ChangeTracker.Entries().ToList();

        foreach (EntityEntry entry in trackedEntities)
        {
            string stringifiedEntity = JsonSerializer.Serialize(entry.Entity);
            logger.LogInformation("Entity logged: {entity}", stringifiedEntity);
        }
    }
}
