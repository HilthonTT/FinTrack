using SharedKernel;

namespace FinTrack.Domain.Expenses;

public sealed class Category : Entity
{
    public Category(Guid userId, string name) 
        : base(Guid.NewGuid())
    {
        Ensure.NotNull(userId, nameof(userId));
        Ensure.NotNull(name, nameof(name));

        UserId = userId;
        Name = name;
    }

    private Category()
    {
    }

    public Guid UserId { get; private set; }

    public string Name { get; private set; }
}
