namespace FinTrack.Persistence.Idempotency;

public sealed class IdempotentRequest
{
    public required Guid Id { get; set; }

    public required string Name { get; set; }

    public required DateTime CreatedOnUtc { get; set; }
}
