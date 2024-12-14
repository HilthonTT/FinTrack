namespace FinTrack.Infrastructure.Authentication;

public interface IRevokeRefreshTokensJob
{
    Task ExecuteAsync();
}
