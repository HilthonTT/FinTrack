using FinTrack.Application.Abstractions.Authentication;
using FinTrack.Application.Abstractions.Caching;
using FinTrack.Application.Abstractions.Emails;
using FinTrack.Infrastructure.Authentication;
using FinTrack.Infrastructure.Caching;
using FinTrack.Infrastructure.Emails;
using FinTrack.Infrastructure.Outbox;
using FinTrack.Infrastructure.Time;
using Hangfire;
using Hangfire.PostgreSql;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using SharedKernel;
using System.Text;

namespace FinTrack.Infrastructure;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration configuration)
    {
        services
            .AddServices()
            .AddEmail()
            .AddCaching(configuration)
            .AddBackgroundJobs(configuration)
            .AddAuthenticationInternal(configuration)
            .AddAuthorizationInternal();

        return services;
    }

    private static IServiceCollection AddServices(this IServiceCollection services)
    {
        services.AddSingleton<IDateTimeProvider, DateTimeProvider>();

        return services;
    }

    private static IServiceCollection AddCaching(this IServiceCollection services, IConfiguration configuration)
    {
        string? redisConnectionString = configuration.GetConnectionString("fintrack-redis");
        Ensure.NotNullOrWhitespace(redisConnectionString);

        services.AddStackExchangeRedisCache(options =>
            options.Configuration = redisConnectionString);

        services.AddSingleton<ICacheService, CacheService>();

        return services;
    }

    private static IServiceCollection AddEmail(this IServiceCollection services)
    {
        services.AddOptions<EmailOptions>().BindConfiguration(EmailOptions.ConfigurationSection);

        services.AddTransient<IEmailService, EmailService>();

        return services;
    }

    private static IServiceCollection AddBackgroundJobs(this IServiceCollection services, IConfiguration configuration)
    {
        string? connectionString = configuration.GetConnectionString("fintrack-db");
        Ensure.NotNullOrWhitespace(connectionString, nameof(connectionString));

        services.AddHangfire(config =>
            config.UsePostgreSqlStorage(options =>
                options.UseNpgsqlConnection(connectionString)));

        services.AddHangfireServer(options => options.SchedulePollingInterval = TimeSpan.FromSeconds(1));

        services.AddScoped<OutboxProcessor>();

        services.AddScoped<IProcessOutboxMessagesJob, ProcessOutboxMessagesJob>();

        return services;
    }

    private static IServiceCollection AddAuthenticationInternal(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
            .AddJwtBearer(o =>
            {
                o.RequireHttpsMetadata = false;
                o.TokenValidationParameters = new TokenValidationParameters
                {
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["Jwt:Secret"]!)),
                    ValidIssuer = configuration["Jwt:Issuer"],
                    ValidAudience = configuration["Jwt:Audience"],
                    ClockSkew = TimeSpan.Zero
                };
            });

        services.AddHttpContextAccessor();
        services.AddScoped<IUserContext, UserContext>();
        services.AddSingleton<IPasswordHasher, PasswordHasher>();
        services.AddSingleton<ITokenProvider, TokenProvider>();

        services.AddScoped<IEmailVerificationLinkFactory, EmailVerificationLinkFactory>();

        return services;
    }

    private static IServiceCollection AddAuthorizationInternal(this IServiceCollection services)
    {
        services.AddAuthorization();

        return services;
    }
}
