namespace FinTrack.Infrastructure.Outbox;

public interface IProcessOutboxMessagesJob
{
    Task ExecuteAsync();
}
