namespace FinTrack.Domain.Shared.ValueObjects;

public sealed record DateRange
{
    private DateRange(DateOnly start, DateOnly end)
    {
        if (start > end)
        {
            throw new InvalidOperationException("Start date must be before or equal to the end date.");
        }

        Start = start;
        End = end;
    }

    public DateOnly Start { get; init; }

    public DateOnly End { get; init; }

    public int LengthInDays => (End.ToDateTime(TimeOnly.MinValue) - Start.ToDateTime(TimeOnly.MinValue)).Days;

    public static DateRange Create(DateOnly start, DateOnly end) => new(start, end);

    public bool OverlapsWith(DateRange other) =>
        Start <= other.End && End >= other.Start;

    public override string ToString() => $"{Start:yyyy-MM-dd} to {End:yyyy-MM-dd}";
}
