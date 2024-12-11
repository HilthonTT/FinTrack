using FinTrack.Application.Abstractions.Data;
using FinTrack.Domain.Users.Repositories;
using FinTrack.Persistence.Interceptors;
using FinTrack.Persistence.Outbox;
using FinTrack.Persistence.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Npgsql;
using SharedKernel;

namespace FinTrack.Persistence;

public static class DependencyInjection
{
    public static IServiceCollection AddPersistence(this IServiceCollection services, IConfiguration configuration)
    {
        services
            .AddDatabase(configuration)
            .AddBackgroundJob();

        return services;
    }

    private static IServiceCollection AddDatabase(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddSingleton<SoftDeleteInterceptor>();
        services.AddSingleton<UpdateAuditableInterceptor>();

        string? connectionString = configuration.GetConnectionString("fintrack-db");
        Ensure.NotNullOrWhitespace(connectionString, nameof(connectionString));

        services.AddDbContext<AppDbContext>((sp, options) =>
        {
            options
                .UseNpgsql(connectionString)
                .UseSnakeCaseNamingConvention()
                .AddInterceptors(
                    sp.GetRequiredService<SoftDeleteInterceptor>(),
                    sp.GetRequiredService<UpdateAuditableInterceptor>());
        });

        services.AddScoped<IUnitOfWork>(sp => sp.GetRequiredService<AppDbContext>());

        services.AddScoped<IUserRepository, UserRepository>();

        services.AddScoped<IRefreshTokenRepository, RefreshTokenRepository>();

        services.AddScoped<IEmailVerificationTokenRepository, EmailVerificationTokenRepository>();

        services.AddScoped<IDbConnectionFactory>(_ => 
            new DbConnectionFactory(new NpgsqlDataSourceBuilder(connectionString).Build()));

        return services;
    }

    private static IServiceCollection AddBackgroundJob(this IServiceCollection services)
    {
        services.AddScoped<OutboxProcessor>();

        services.AddHostedService<OutboxBackgroundService>();

        return services;
    }
}
