﻿using FinTrack.Application.Abstractions.Data;
using FinTrack.Domain.Users.Repositories;
using FinTrack.Persistence.Constants;
using FinTrack.Persistence.Context;
using FinTrack.Persistence.Interceptors;
using FinTrack.Persistence.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Npgsql;
using SharedKernel;

namespace FinTrack.Persistence;

public static class DependencyInjection
{
    public static IServiceCollection AddPersistence(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddSingleton<SoftDeleteInterceptor>();
        services.AddSingleton<UpdateAuditableInterceptor>();
        services.AddSingleton<InsertOutboxMessagesInterceptor>();

        string? connectionString = configuration.GetConnectionString("fintrack-db");
        Ensure.NotNullOrWhitespace(connectionString, nameof(connectionString));

        services.AddDbContext<AppDbContext>((sp, options) =>
        {
            options
                .UseNpgsql(connectionString, npgsqlOptions =>
                    npgsqlOptions.MigrationsHistoryTable(HistoryRepository.DefaultTableName, Schemas.Default))
                .UseSnakeCaseNamingConvention()
                .AddInterceptors(
                    sp.GetRequiredService<SoftDeleteInterceptor>(),
                    sp.GetRequiredService<UpdateAuditableInterceptor>(),
                    sp.GetRequiredService<InsertOutboxMessagesInterceptor>());
        });

        services.AddScoped<IUnitOfWork>(sp => sp.GetRequiredService<AppDbContext>());

        services.AddScoped<IUserRepository, UserRepository>();

        services.AddScoped<IRefreshTokenRepository, RefreshTokenRepository>();

        services.AddScoped<IEmailVerificationTokenRepository, EmailVerificationTokenRepository>();

        services.AddScoped<IDbConnectionFactory>(_ =>
            new DbConnectionFactory(new NpgsqlDataSourceBuilder(connectionString).Build()));

        return services;
    }
}
