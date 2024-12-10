IDistributedApplicationBuilder builder = DistributedApplication.CreateBuilder(args);

IResourceBuilder<PostgresServerResource> postgres = builder.AddPostgres("fintrack-db")
    .WithDataVolume()
    .WithPgAdmin();

IResourceBuilder<RabbitMQServerResource> rabbitMq = builder.AddRabbitMQ("fintrack-mq")
    .WithManagementPlugin();

builder.AddProject<Projects.FinTrack_Api>("fintrack-api")
    .WithReference(postgres)
    .WithReference(rabbitMq);

await builder.Build().RunAsync();
