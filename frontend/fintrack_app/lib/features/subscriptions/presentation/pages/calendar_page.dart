import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/subscriptions/presentation/widgets/calendar_header.dart';
import 'package:fintrack_app/features/subscriptions/presentation/widgets/calendar_list.dart';
import 'package:fintrack_app/features/subscriptions/presentation/widgets/calendar_list_header.dart';
import 'package:flutter/material.dart';

final class CalendarPage extends StatefulWidget {
  static MaterialPageRoute<CalendarPage> route() => MaterialPageRoute(
        builder: (context) => const CalendarPage(),
      );

  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

final class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.gray,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CalendarHeader(
              selectedDate: selectedDate,
              onDateSelected: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
            const CalendarListHeader(),
            const CalendarList(),
            const SizedBox(height: 160),
          ],
        ),
      ),
    );
  }
}
