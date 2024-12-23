import 'package:fintrack_app/core/common/widgets/custom_arc_180_painter.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class BudgetHeaderBackground extends StatelessWidget {
  final double arcSize;

  const BudgetHeaderBackground({
    super.key,
    required this.arcSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Center(
          child: SizedBox(
            width: arcSize,
            height: arcSize,
            child: CustomPaint(
              painter: CustomArc180Painter(
                drawArcs: [
                  ArcValueModel(color: AppPalette.secondaryG, value: 20),
                  ArcValueModel(color: AppPalette.secondary, value: 45),
                  ArcValueModel(color: AppPalette.primary10, value: 70),
                ],
                end: 50,
                width: 12,
                bgWidth: 8,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/images/settings.png",
                  width: 25,
                  height: 25,
                  color: AppPalette.gray30,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
