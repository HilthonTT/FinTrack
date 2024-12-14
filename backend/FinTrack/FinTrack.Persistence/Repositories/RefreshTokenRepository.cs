using FinTrack.Domain.Users;
using FinTrack.Domain.Users.Repositories;
using FinTrack.Persistence.Context;
using Microsoft.EntityFrameworkCore;

namespace FinTrack.Persistence.Repositories;

internal sealed class RefreshTokenRepository(AppDbContext dbContext) : IRefreshTokenRepository
{
    public Task<RefreshToken?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default)
    {
        return dbContext.RefreshTokens
            .Where(r => r.Id == id)
            .Include(r => r.UserId)
            .FirstOrDefaultAsync(cancellationToken);
    }

    public Task<RefreshToken?> GetByTokenAsync(string token, CancellationToken cancellationToken = default)
    {
        return dbContext.RefreshTokens
            .Where(r => r.Token == token)
            .Include(r => r.User)
            .FirstOrDefaultAsync(cancellationToken);
    }

    public Task DeleteAllAsync(Guid userId, CancellationToken cancellationToken = default)
    {
        return dbContext.RefreshTokens
            .Where(r => r.UserId == userId)
            .ExecuteDeleteAsync(cancellationToken);
    }

    public void Insert(RefreshToken refreshToken)
    {
        dbContext.RefreshTokens.Add(refreshToken);
    }

    public void Remove(RefreshToken refreshToken)
    {
        dbContext.RefreshTokens.Remove(refreshToken);
    }
}
