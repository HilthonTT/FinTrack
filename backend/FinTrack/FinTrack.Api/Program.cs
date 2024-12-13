using FinTrack.Persistence;
using FinTrack.Events;
using FinTrack.ServiceDefaults;
using FinTrack.Api.Extensions;
using FinTrack.Infrastructure;
using FinTrack.Application;
using FinTrack.Api;

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

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();

    app.ApplyMigrations();
}

app.UseHttpsRedirection();

app.UseAuthentication();

app.UseAuthorization();

await app.RunAsync();

// REMARK: Required for functional and integration tests to work.
namespace FinTrack.Api
{
    public partial class Program;
}
