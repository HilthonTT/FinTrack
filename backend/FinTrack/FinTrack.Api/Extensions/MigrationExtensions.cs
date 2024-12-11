using FinTrack.Persistence;
using Microsoft.EntityFrameworkCore;

namespace FinTrack.Api.Extensions;

internal static class MigrationExtensions
{
    public static void ApplyMigrations(this IApplicationBuilder app)
    {
        using IServiceScope scope = app.ApplicationServices.CreateScope();

        using AppDbContext usersDbContext =
            scope.ServiceProvider.GetRequiredService<AppDbContext>();

        usersDbContext.Database.Migrate();
    }
}
