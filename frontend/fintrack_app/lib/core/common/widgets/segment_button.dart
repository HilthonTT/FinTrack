import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class SegmentButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isActive;

  const SegmentButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onPressed,
      child: Container(
        decoration: _buildDecoration(),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? AppPalette.white : AppPalette.gray30,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  BoxDecoration? _buildDecoration() {
    if (isActive) {
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
