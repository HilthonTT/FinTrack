import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class LoadMoreButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool hasMore;

  const LoadMoreButton({
    super.key,
    required this.onPressed,
    required this.hasMore,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: hasMore ? onPressed : null,
      child: Container(
        width: 150,
        decoration: _buildDecoration(),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Text(
          hasMore ? "Load more" : "All results loaded",
          style: TextStyle(
            color: hasMore ? AppPalette.white : AppPalette.gray30,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  BoxDecoration? _buildDecoration() {
    if (hasMore) {
      return BoxDecoration(
        border: Border.all(
          color: AppPalette.border.withOpacity(0.15),
        ),
        color: AppPalette.gray60.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      );
    }

    return null;
  }
}
