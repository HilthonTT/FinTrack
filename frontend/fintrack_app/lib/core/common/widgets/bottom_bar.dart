import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppPalette.gray80,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () => _onPress(0),
                              icon: Image.asset(
                                "assets/images/home.png",
                                width: 20,
                                height: 20,
                                color: _getTabColor(0),
                              ),
                            ),
                            IconButton(
                              onPressed: () => _onPress(1),
                              icon: Image.asset(
                                "assets/images/budgets.png",
                                width: 20,
                                height: 20,
                                color: _getTabColor(1),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppPalette.secondary
                                          .withOpacity(0.25),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Image.asset(
                                  "assets/images/center_btn.png",
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => _onPress(2),
                              icon: Image.asset(
                                "assets/images/calendar.png",
                                width: 20,
                                height: 20,
                                color: _getTabColor(2),
                              ),
                            ),
                            IconButton(
                              onPressed: () => _onPress(3),
                              icon: Image.asset(
                                "assets/images/creditcards.png",
                                width: 20,
                                height: 20,
                                color: _getTabColor(3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onPress(int tab) {
    setState(() {
      _selectedTab = tab;
    });
  }

  Color _getTabColor(int tab) {
    if (tab == _selectedTab) {
      return AppPalette.white;
    }

    return AppPalette.gray30;
  }
}
