using SharedKernel;

namespace FinTrack.Domain.Users;

public sealed class Permission(int id, string name) : Enumeration<Permission>(id, name)
{
    public static readonly Permission UsersRead = new(1, "users:read");
}
