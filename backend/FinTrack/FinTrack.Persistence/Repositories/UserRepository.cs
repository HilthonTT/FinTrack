using FinTrack.Domain.Users;
using FinTrack.Domain.Users.Repositories;
using FinTrack.Domain.Users.ValueObjects;
using FinTrack.Persistence.Context;
using Microsoft.EntityFrameworkCore;

namespace FinTrack.Persistence.Repositories;

internal sealed class UserRepository(AppDbContext dbContext) : IUserRepository
{
    public Task<User?> GetByEmailAsync(Email email, CancellationToken cancellationToken = default)
    {
        return dbContext.Users
            .Where(u => u.Email.Value == email.Value)
            .FirstOrDefaultAsync(cancellationToken);
    }

    public Task<User?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default)
    {
        return dbContext.Users
            .Where(u => u.Id == id)
            .FirstOrDefaultAsync(cancellationToken);
    }

    public async Task<bool> IsEmailUniqueAsync(Email email, CancellationToken cancellationToken = default)
    {
        return !await dbContext.Users.AnyAsync(u => u.Email.Value == email.Value, cancellationToken);
    }

    public void Insert(User user)
    {
        dbContext.Users.Add(user);
    }

    public void Remove(User user)
    {
        dbContext.Users.Remove(user);
    }
}
