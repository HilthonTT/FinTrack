import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class ImageButton extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;

  const ImageButton({
    super.key,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppPalette.border.withValues(alpha: .15),
          ),
          color: AppPalette.gray60.withValues(alpha: .2),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Image.asset(
          image,
          width: 50,
          height: 50,
          color: AppPalette.gray70,
        ),
      ),
    );
  }
}
