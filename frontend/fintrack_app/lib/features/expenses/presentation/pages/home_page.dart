import 'package:fintrack_app/core/common/widgets/bottom_bar.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class HomePage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomePage());

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.gray,
      body: const Stack(
        children: [
          Text("Hello"),
          BottomBar(),
        ],
      ),
    );
  }
}
