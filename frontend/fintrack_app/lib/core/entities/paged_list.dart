final class PagedList<T> {
  final List<T> items;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;

  const PagedList({
    required this.items,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
  });
}
