using SharedKernel;

namespace FinTrack.Domain.Users;

public sealed class EmailVerificationToken : Entity
{
    public Guid UserId { get; private set; }

    public int Code { get; private set; }

    public DateTime CreatedOnUtc { get; private set; }

    public DateTime ExpiresOnUtc { get; private set; }

    public User User { get; private set; } = default!;

    public EmailVerificationToken(Guid id, Guid userId, DateTime createdOnUtc)
        : base(id)
    {
        UserId = userId;
        Code = GenerateSixDigitCode();
        CreatedOnUtc = createdOnUtc;
        ExpiresOnUtc = createdOnUtc.AddDays(1);
    }

    private EmailVerificationToken()
    {
    }

    private static int GenerateSixDigitCode()
    {
        var random = new Random();
        return random.Next(100000, 1000000);
    }
}
