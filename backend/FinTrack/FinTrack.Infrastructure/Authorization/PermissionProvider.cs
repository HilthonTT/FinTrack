using FinTrack.Domain.Users;
using FinTrack.Domain.Users.Repositories;

namespace FinTrack.Infrastructure.Authorization;

internal sealed class PermissionProvider(IUserRepository userRepository)
{
    public async Task<HashSet<string>> GetForUserIdAsync(Guid userId, CancellationToken cancellationToken = default)
    {
        IReadOnlyCollection<Role>[] roles = await userRepository.GetRolesAsync(userId, cancellationToken);

        HashSet<string> permissionsSet = roles
            .SelectMany(x => x)
            .SelectMany(x => x.Permissions)
            .Select(x => x.Name)
            .ToHashSet();

        return permissionsSet;
    }
}
