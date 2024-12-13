namespace FinTrack.Infrastructure.Outbox;

public sealed record OutboxMessage(Guid Id, string Type, string Content);
