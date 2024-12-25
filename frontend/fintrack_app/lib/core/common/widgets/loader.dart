import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppPalette.secondary,
      ),
    );
  }
}
