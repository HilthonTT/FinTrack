using Microsoft.EntityFrameworkCore;

namespace FinTrack.Contracts.Common;

public sealed class PagedList<T>
{
    private PagedList(List<T> items, int pageSize, int totalCount)
    {
        Items = items;

        PageSize = pageSize;
        TotalCount = totalCount;
    }

    public List<T> Items { get; init; }

    public int PageSize { get; set; }

    public int TotalCount { get; init; }

    public bool HasNextPage => PageSize < TotalCount;

    public static async Task<PagedList<T>> CreateAsync(
        IQueryable<T> query,
        int pageSize, 
        CancellationToken cancellationToken = default)
    {
        int totalCount = await query.CountAsync(cancellationToken);
        List<T> items = await query.Take(pageSize).ToListAsync(cancellationToken);

        return new(items, pageSize, totalCount);
    }
}
