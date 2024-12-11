namespace SharedKernel;

public interface ISoftDeletable
{
    bool IsDeleted { get; }

    public DateTime? DeletedOnUtc { get; }
}
