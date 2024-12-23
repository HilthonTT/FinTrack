import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/budgets/presentation/widgets/budget_create_button.dart';
import 'package:fintrack_app/features/budgets/presentation/widgets/budget_header_section.dart';
import 'package:fintrack_app/features/budgets/presentation/widgets/budget_list.dart';
import 'package:flutter/material.dart';

final class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.gray,
      body: LayoutBuilder(builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth >= 800;

        final double containerWidth =
            isDesktop ? double.infinity : constraints.maxWidth;

        final double imageHeight =
            isDesktop ? 400 : constraints.maxHeight * 0.45;

        final double arcSize = isDesktop ? 350 : 200;

        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  BudgetHeaderSection(
                    containerWidth: containerWidth,
                    imageHeight: imageHeight,
                    arcSize: arcSize,
                  ),
                  BudgetList(),
                  const SizedBox(height: 10),
                  BudgetCreateButton(),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
