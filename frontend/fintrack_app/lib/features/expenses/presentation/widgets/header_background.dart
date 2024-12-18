import 'package:fintrack_app/core/common/widgets/custom_arc_painter.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class HeaderBackground extends StatelessWidget {
  final double arcSize;

  const HeaderBackground({super.key, required this.arcSize});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          width: arcSize,
          height: arcSize,
          child: const CustomPaint(
            painter: CustomArcPainter(
              end: 220,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
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
