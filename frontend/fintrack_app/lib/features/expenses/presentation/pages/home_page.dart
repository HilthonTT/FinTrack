import 'package:fintrack_app/core/common/widgets/bottom_bar.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/expenses/presentation/widgets/expense_list.dart';
import 'package:fintrack_app/features/expenses/presentation/widgets/header_section.dart';
import 'package:flutter/material.dart';

final class HomePage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomePage());

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.gray,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isDesktop = constraints.maxWidth >= 800;

          final double containerWidth =
              isDesktop ? double.infinity : constraints.maxWidth;

          final double imageHeight =
              isDesktop ? 400 : constraints.maxHeight * 0.45;

          final double arcSize = isDesktop ? 300 : 200;

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    HeaderSection(
                      containerWidth: containerWidth,
                      imageHeight: imageHeight,
                      arcSize: arcSize,
                    ),
                    const SizedBox(height: 24),
                    ExpenseList(),
                    const SizedBox(height: 150),
                  ],
                ),
              ),
              const BottomBar(),
            ],
          );
        },
      ),
    );
  }
}
