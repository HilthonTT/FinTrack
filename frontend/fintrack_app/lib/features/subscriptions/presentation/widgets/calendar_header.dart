import 'dart:math';

import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:fintrack_app/core/common/utils/toast_helper.dart';
import 'package:fintrack_app/core/common/widgets/settings_button.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/subscriptions/presentation/bloc/subscriptions_bloc.dart';
import 'package:fintrack_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

final class CalendarHeader extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const CalendarHeader({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<CalendarHeader> createState() => _CalendarHeaderState();
}

final class _CalendarHeaderState extends State<CalendarHeader> {
  late FToast fToast;

  int subscriptionsCount = 0;

  @override
  void initState() {
    super.initState();

    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);

    final event = GetSubscriptionsEvent();
    context.read<SubscriptionsBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();

    final calendarController = CalendarAgendaController();

    return Container(
      decoration: BoxDecoration(
        color: AppPalette.gray70.withValues(alpha: .5),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Calendar",
                            style: TextStyle(
                              color: AppPalette.gray30,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const Spacer(),
                          SettingsButton(),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Subscriptions schedules",
                    style: TextStyle(
                      color: AppPalette.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocConsumer<SubscriptionsBloc, SubscriptionsState>(
                    listener: (context, state) {
                      if (state is SubscriptionsFailure) {
                        showToast(fToast, state.error, Icons.error);
                      } else if (state is SubscriptionsLoadedSuccess) {
                        setState(() {
                          final pagedSubscriptions = state.pagedSubscriptions;

                          subscriptionsCount = pagedSubscriptions.totalCount;
                        });
                      }
                    },
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "$subscriptionsCount subscriptions for today",
                            style: TextStyle(
                              color: AppPalette.gray30,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            CalendarAgenda(
              controller: calendarController,
              backgroundColor: AppPalette.transparent,
              calendarBackground: AppPalette.gray80,
              locale: "en",
              weekDay: WeekDay.short,
              fullCalendarDay: WeekDay.short,
              selectedDateColor: AppPalette.gray80,
              initialDate: DateTime.now(),
              calendarEventColor: AppPalette.secondary,
              firstDate: DateTime.now().subtract(const Duration(days: 140)),
              lastDate: DateTime.now().add(const Duration(days: 140)),
              events: List.generate(
                100,
                (index) => DateTime.now().subtract(
                  Duration(
                    days: index * random.nextInt(5),
                  ),
                ),
              ),
              onDateSelected: widget.onDateSelected,
            )
          ],
        ),
      ),
    );
  }
}
