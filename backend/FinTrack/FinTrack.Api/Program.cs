using FinTrack.Persistence;
using FinTrack.Events;
using FinTrack.ServiceDefaults;
using FinTrack.Api.Extensions;
using FinTrack.Infrastructure;
using FinTrack.Application;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.AddServiceDefaults();

builder.Services.AddOpenApi();

builder.Services
    .AddPersistence(builder.Configuration)
    .AddEvents(builder.Configuration)
    .AddInfrastructure(builder.Configuration)
    .AddApplication();

WebApplication app = builder.Build();

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
