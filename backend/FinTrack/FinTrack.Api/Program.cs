using FinTrack.Persistence;
using FinTrack.Events;
using FinTrack.ServiceDefaults;
using FinTrack.Api.Extensions;
using FinTrack.Infrastructure;
using FinTrack.Application;
using FinTrack.Api;
using Scalar.AspNetCore;
using FinTrack.Api.Constants;
using Zylo.Api.Extensions;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.AddServiceDefaults();

builder.Services
    .AddPersistence(builder.Configuration)
    .AddEvents(builder.Configuration)
    .AddInfrastructure(builder.Configuration)
    .AddApplication()
    .AddPresentation();

WebApplication app = builder.Build();

app.MapEndpoints();

app.MapDefaultEndpoints();

app.UseBackgroundJobs();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.MapScalarApiReference(options =>
    {
        options
            .WithTitle("FinTrack API")
            .WithTheme(ScalarTheme.DeepSpace)
            .WithDefaultHttpClient(ScalarTarget.CSharp, ScalarClient.HttpClient);
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
