using FinTrack.Infrastructure.Outbox;
using Hangfire;

namespace Zylo.Api.Extensions;

public static class BackgroundJobExtensions
{
    public static IApplicationBuilder UseBackgroundJobs(this WebApplication app)
    {
        IRecurringJobManagerV2 recurringJobManager = app.Services.GetRequiredService<IRecurringJobManagerV2>();

        recurringJobManager.AddOrUpdate<IProcessOutboxMessagesJob>(
            "outbox-processor",
            job => job.ExecuteAsync(),
            app.Configuration["BackgroundJobs:Outbox:Schedule"]);

        return app;
    }
}
