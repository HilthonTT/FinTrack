IDistributedApplicationBuilder builder = DistributedApplication.CreateBuilder(args);

IResourceBuilder<PostgresServerResource> postgres = builder.AddPostgres("fintrack-db")
    .WithDataVolume()
    .WithPgAdmin();

IResourceBuilder<RabbitMQServerResource> rabbitMq = builder.AddRabbitMQ("fintrack-mq")
    .WithManagementPlugin();

IResourceBuilder<RedisResource> redis = builder.AddRedis("fintrack-redis")
    .WithRedisInsight()
    .WithDataVolume();

builder.AddProject<Projects.FinTrack_Api>("fintrack-api")
    .WithReference(postgres)
    .WithReference(rabbitMq)
    .WithReference(redis)
    .WaitFor(postgres)
    .WaitFor(rabbitMq);

await builder.Build().RunAsync();
