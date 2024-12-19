using FinTrack.Api;
using FinTrack.Application.Abstractions.Data;
using Hangfire;
using Hangfire.PostgreSql;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.AspNetCore.TestHost;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.StackExchangeRedis;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Microsoft.Extensions.DependencyInjection;
using Testcontainers.PostgreSql;
using Testcontainers.RabbitMq;
using Testcontainers.Redis;
using FinTrack.Persistence.Context;
using Npgsql;

namespace Application.IntegrationTests.Abstractions;

public sealed class IntegrationTestWebAppFactory : WebApplicationFactory<Program>, IAsyncLifetime
{
    private readonly PostgreSqlContainer _dbContainer = new PostgreSqlBuilder()
       .WithImage("postgres:latest")
       .WithDatabase("fintrack")
       .WithUsername("postgres")
       .WithPassword("postgres")
       .Build();

    private readonly RedisContainer _redisContainer = new RedisBuilder()
       .WithImage("redis:latest")
       .Build();

    private readonly RabbitMqContainer _rabbitMqContainer = new RabbitMqBuilder()
        .WithImage("rabbitmq:management")
        .WithUsername("guest")
        .WithPassword("guest")
        .Build();

    protected override void ConfigureWebHost(IWebHostBuilder builder)
    {
        builder.ConfigureTestServices(services =>
        {
            services.RemoveAll(typeof(GlobalConfiguration));
            services.AddHangfire(config =>
            {
                config.UsePostgreSqlStorage(options =>
                    options.UseNpgsqlConnection(_dbContainer.GetConnectionString()));
            });

            services.RemoveAll(typeof(IDbConnectionFactory));
            services.AddSingleton<IDbConnectionFactory>(_ =>
                new DbConnectionFactory(new NpgsqlDataSourceBuilder(_dbContainer.GetConnectionString()).Build()));

            services.RemoveAll(typeof(DbContextOptions<AppDbContext>));
            services.AddDbContext<AppDbContext>(options =>
                options
                    .UseNpgsql(_dbContainer.GetConnectionString()));

            services.RemoveAll(typeof(RedisCacheOptions));
            services.AddStackExchangeRedisCache(redisCacheOptions =>
                redisCacheOptions.Configuration = _redisContainer.GetConnectionString());
        });
    }

    public async Task InitializeAsync()
    {
        await _dbContainer.StartAsync();
        await _redisContainer.StartAsync();
        await _rabbitMqContainer.StartAsync();
    }

    async Task IAsyncLifetime.DisposeAsync()
    {
        await _dbContainer.DisposeAsync();
        await _redisContainer.DisposeAsync();
        await _rabbitMqContainer.DisposeAsync();
    }
}
