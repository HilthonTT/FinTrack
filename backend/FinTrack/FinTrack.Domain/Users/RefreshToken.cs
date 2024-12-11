using SharedKernel;

namespace FinTrack.Domain.Users;

public sealed class RefreshToken : Entity
{
    public string Token { get; private set; } = string.Empty;

    public Guid UserId { get; private set; }

    public DateTime ExpiresOnUtc { get; private set; }

    public User User { get; private set; } = default!;

    public RefreshToken(Guid id, string token, Guid userId, DateTime expiresOnUtc)
        : base(id)  
    {
        Token = token;
        UserId = userId;
        ExpiresOnUtc = expiresOnUtc;
    }
}
