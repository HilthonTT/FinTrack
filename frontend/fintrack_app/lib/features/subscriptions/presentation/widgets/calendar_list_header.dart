import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class CalendarListHeader extends StatelessWidget {
  const CalendarListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "January",
                style: TextStyle(
                  color: AppPalette.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "\$24.98",
                style: TextStyle(
                  color: AppPalette.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "01.08.2023",
                style: TextStyle(
                  color: AppPalette.gray30,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "in upcoming bills",
                style: TextStyle(
                  color: AppPalette.gray30,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
