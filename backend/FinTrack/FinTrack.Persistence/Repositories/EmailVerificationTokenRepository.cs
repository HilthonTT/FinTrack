using FinTrack.Domain.Users;
using FinTrack.Domain.Users.Repositories;
using FinTrack.Persistence.Context;
using Microsoft.EntityFrameworkCore;

namespace FinTrack.Persistence.Repositories;

internal sealed class EmailVerificationTokenRepository(AppDbContext dbContext) : IEmailVerificationTokenRepository
{
    public Task<EmailVerificationToken?> GetByCodeAsync(int code, CancellationToken cancellationToken = default)
    {
        return dbContext.EmailVerificationTokens
           .Where(e => e.Code == code)
           .Include(e => e.User)
           .ThenInclude(u => u.Roles)
           .AsSplitQuery()
           .FirstOrDefaultAsync(cancellationToken);
    }

    public Task<EmailVerificationToken?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default)
    {
        return dbContext.EmailVerificationTokens
            .Where(e => e.Id == id)
            .Include(e => e.User)
            .ThenInclude(u => u.Roles)
            .AsSplitQuery()
            .FirstOrDefaultAsync(cancellationToken);
    }

    public Task<EmailVerificationToken?> GetMostRecentAsync(Guid userId, CancellationToken cancellationToken = default)
    {
        return dbContext.EmailVerificationTokens
            .Where(e => e.UserId == userId && e.ExpiresOnUtc > DateTime.UtcNow)
            .OrderByDescending(e => e.CreatedOnUtc)
            .Include(e => e.User)
            .FirstOrDefaultAsync(cancellationToken);
    }

    public void Insert(EmailVerificationToken emailVerificationToken)
    {
        dbContext.Add(emailVerificationToken);
    }

    public void Remove(EmailVerificationToken emailVerificationToken)
    {
        dbContext.Remove(emailVerificationToken);
    }
}
