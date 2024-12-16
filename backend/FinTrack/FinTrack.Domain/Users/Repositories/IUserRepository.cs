using FinTrack.Domain.Users.ValueObjects;

namespace FinTrack.Domain.Users.Repositories;

public interface IUserRepository
{
    Task<User?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);

    Task<User?> GetByEmailAsync(Email email, CancellationToken cancellationToken = default);

    void Insert(User user);

    void Remove(User user);

    Task<bool> IsEmailUniqueAsync(Email email, CancellationToken cancellationToken = default);

    Task<IReadOnlyCollection<Role>[]> GetRolesAsync(Guid userId, CancellationToken cancellationToken = default);
}
