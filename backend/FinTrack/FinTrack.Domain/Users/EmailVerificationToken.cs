using SharedKernel;

namespace FinTrack.Domain.Users;

public sealed class EmailVerificationToken : Entity
{
    public Guid UserId { get; private set; }

    public DateTime CreatedOnUtc { get; private set; }

    public DateTime ExpiresOnUtc { get; private set; }

    public User User { get; private set; } = default!;

    public EmailVerificationToken(Guid id, Guid userId, DateTime createdOnUtc)
        : base(id)
    {
        UserId = userId;
        CreatedOnUtc = createdOnUtc;
        ExpiresOnUtc = createdOnUtc.AddDays(1);
    }
}
