import 'package:fintrack_app/core/common/utils/toast_helper.dart';
import 'package:fintrack_app/core/common/widgets/loader.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:fintrack_app/features/subscriptions/presentation/bloc/subscriptions_bloc.dart';
import 'package:fintrack_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

final class CalendarListHeader extends StatefulWidget {
  const CalendarListHeader({super.key});

  @override
  State<CalendarListHeader> createState() => _CalendarListHeaderState();
}

final class _CalendarListHeaderState extends State<CalendarListHeader> {
  late FToast fToast;

  double amountsThisMonth = 0;

  void _handleLoadSubscriptions() {
    final event = GetSubscriptionsEvent();
    context.read<SubscriptionsBloc>().add(event);
  }

  void _handleLoadSettings() {
    final event = SettingsGetSettingsEvent();
    context.read<SettingsBloc>().add(event);
  }

  @override
  void initState() {
    super.initState();

    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);

    _handleLoadSubscriptions();

    _handleLoadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsFailure) {
          showToast(fToast, state.error, Icons.error);
        }
      },
      builder: (context, state) {
        if (state is SettingsLoading) {
          return const Loader();
        }

        if (state is SettingsSuccess) {
          final settings = state.settings;

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
                    BlocConsumer<SubscriptionsBloc, SubscriptionsState>(
                      listener: (context, state) {
                        if (state is SubscriptionsFailure) {
                          showToast(fToast, state.error, Icons.error);
                        } else if (state is SubscriptionsLoadedSuccess) {
                          final pagedSubscriptions = state.pagedSubscriptions;

                          final subscriptions = pagedSubscriptions.items;

                          final totalAmount = subscriptions.fold<double>(
                            0.0,
                            (sum, subscription) => sum + subscription.amount,
                          );

                          setState(() {
                            amountsThisMonth = totalAmount;
                          });
                        }
                      },
                      builder: (context, state) {
                        return Text(
                          "${amountsThisMonth.toStringAsPrecision(2)} ${settings.currency}",
                          style: TextStyle(
                            color: AppPalette.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
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

        return const SizedBox();
      },
    );
  }
}
