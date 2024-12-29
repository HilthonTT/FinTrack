import 'package:dotted_border/dotted_border.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class CreateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CreateButton({super.key, required this.onPressed});

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
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.add,
              color: AppPalette.gray30,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
