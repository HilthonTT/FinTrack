import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class CalendarLoadMoreButton extends StatelessWidget {
  final VoidCallback onLoadMore;
  final bool canLoadMore;

  const CalendarLoadMoreButton({
    super.key,
    required this.onLoadMore,
    required this.canLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isMobile = screenWidth < 600;

    final imageSize = isMobile ? 60.0 : 100.0;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: canLoadMore ? onLoadMore : null,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                color: canLoadMore ? AppPalette.white : AppPalette.gray20,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(8.0),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Load more",
              style: TextStyle(
                color: canLoadMore ? AppPalette.white : AppPalette.gray20,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
