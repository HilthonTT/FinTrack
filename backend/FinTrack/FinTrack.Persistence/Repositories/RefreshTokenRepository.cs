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
            .FirstOrDefaultAsync(cancellationToken);
    }

    public Task<RefreshToken?> GetByTokenAsync(string token, CancellationToken cancellationToken = default)
    {
        return dbContext.RefreshTokens
            .Where(r => r.Token == token)
            .FirstOrDefaultAsync(cancellationToken);
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
