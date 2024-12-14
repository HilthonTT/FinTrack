using FinTrack.Infrastructure.Authentication;
using FinTrack.Infrastructure.Outbox;
using Hangfire;

namespace Zylo.Api.Extensions;

public static class BackgroundJobExtensions
{
    public static IApplicationBuilder UseBackgroundJobs(this WebApplication app)
    {
        IRecurringJobManagerV2 recurringJobManager = app.Services.GetRequiredService<IRecurringJobManagerV2>();

        string? schedule = app.Configuration["BackgroundJobs:Outbox:Schedule"];

        recurringJobManager.AddOrUpdate<IProcessOutboxMessagesJob>(
            "outbox-processor",
            job => job.ExecuteAsync(),
            schedule,
            new RecurringJobOptions { TimeZone = TimeZoneInfo.Utc });

        recurringJobManager.AddOrUpdate<IRevokeRefreshTokensJob>(
            "revoke-refresh-token-processor",
            job => job.ExecuteAsync(),
            schedule,
            new RecurringJobOptions { TimeZone = TimeZoneInfo.Utc });

        return app;
    }
}
