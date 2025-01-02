import 'package:dotted_border/dotted_border.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class SecondaryButton extends StatelessWidget {
  final VoidCallback onPressed;

  final double width;
  final double height;
  final String title;
  final IconData? icon;

  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.width,
    required this.height,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onPressed,
        child: DottedBorder(
          dashPattern: const [5, 4],
          strokeWidth: 1,
          borderType: BorderType.RRect,
          radius: const Radius.circular(16),
          color: AppPalette.border.withValues(alpha: .1),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color: AppPalette.white,
                  ),
                if (icon != null) const SizedBox(width: 5),
                Text(
                  title,
                  style: TextStyle(
                    color: AppPalette.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
