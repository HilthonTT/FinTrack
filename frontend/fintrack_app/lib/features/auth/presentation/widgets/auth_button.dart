import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class AuthButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const AuthButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
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
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: AppPalette.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
