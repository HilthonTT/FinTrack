using FinTrack.Persistence;
using FinTrack.Events;
using FinTrack.ServiceDefaults;
using FinTrack.Api.Extensions;
using FinTrack.Infrastructure;
using FinTrack.Application;
using FinTrack.Api;
using FinTrack.Api.Constants;
using Zylo.Api.Extensions;
using Asp.Versioning.Builder;
using Asp.Versioning;
using Hangfire;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.AddServiceDefaults();

builder.Services
    .AddPersistence(builder.Configuration)
    .AddEvents(builder.Configuration)
    .AddInfrastructure(builder.Configuration)
    .AddApplication()
    .AddPresentation();

WebApplication app = builder.Build();

ApiVersionSet apiVersionSet = app.NewApiVersionSet()
    .HasApiVersion(new ApiVersion(1))
    .ReportApiVersions()
    .Build();

RouteGroupBuilder versionedGroup = app
    .MapGroup("api/v{version:apiVersion}")
    .WithApiVersionSet(apiVersionSet);

app.MapEndpoints(versionedGroup);

app.MapDefaultEndpoints();

app.UseBackgroundJobs();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.UseSwaggerWithUi();
    app.UseScalarApiReference();

    app.UseHangfireDashboard(options: new DashboardOptions
    {
        Authorization = [],
        DarkModeEnabled = true
    });

    app.ApplyMigrations();
}

app.UseCors(CorsPolicy.AllowAllHeaders);

app.UseHttpsRedirection();

app.UseExceptionHandler();

app.UseStatusCodePages();

app.UseAuthentication();

app.UseAuthorization();

app.UseRateLimiter();

await app.RunAsync();

// REMARK: Required for functional and integration tests to work.
namespace FinTrack.Api
{
    public partial class Program;
}
