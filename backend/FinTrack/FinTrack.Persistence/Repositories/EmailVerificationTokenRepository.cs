using FinTrack.Domain.Users;
using FinTrack.Domain.Users.Repositories;
using Microsoft.EntityFrameworkCore;

namespace FinTrack.Persistence.Repositories;

internal sealed class EmailVerificationTokenRepository(AppDbContext dbContext) : IEmailVerificationTokenRepository
{
    public Task<EmailVerificationToken?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default)
    {
        return dbContext.EmailVerificationTokens
            .Where(e => e.Id == id)
            .FirstOrDefaultAsync(cancellationToken);
    }

    public void Insert(EmailVerificationToken emailVerificationToken)
    {
        dbContext.Add(emailVerificationToken);
    }
}
