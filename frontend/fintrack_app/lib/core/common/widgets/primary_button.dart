import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;

  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/primary_btn.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppPalette.secondary.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: AppPalette.white,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
