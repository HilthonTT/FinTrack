namespace FinTrack.Domain.Users.Repositories;

public interface IRefreshTokenRepository
{
    Task<RefreshToken?> GetByTokenAsync(string token, CancellationToken cancellationToken = default);

    Task<RefreshToken?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);

    void Insert(RefreshToken refreshToken);

    void Remove(RefreshToken refreshToken);

    Task DeleteAllAsync(Guid userId, CancellationToken cancellationToken = default);
}
