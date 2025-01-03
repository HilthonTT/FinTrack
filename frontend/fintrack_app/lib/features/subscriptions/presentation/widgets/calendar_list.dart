import 'package:fintrack_app/core/common/utils/image_path.dart';
import 'package:fintrack_app/core/common/utils/toast_helper.dart';
import 'package:fintrack_app/core/common/widgets/loader.dart';
import 'package:fintrack_app/features/subscriptions/presentation/bloc/subscriptions_bloc.dart';
import 'package:fintrack_app/features/subscriptions/presentation/widgets/calendar_load_more_button.dart';
import 'package:fintrack_app/features/subscriptions/presentation/widgets/subscription_card.dart';
import 'package:fintrack_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

final class CalendarList extends StatefulWidget {
  const CalendarList({super.key});

  @override
  State<CalendarList> createState() => _CalendarListState();
}

final class _CalendarListState extends State<CalendarList> {
  late FToast fToast;

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
    final screenWidth = MediaQuery.of(context).size.width;

    final int crossAxisCount = screenWidth < 600 ? 2 : 5;

    final double aspectRatio = screenWidth < 600 ? 0.8 : 1;

    return BlocConsumer<SubscriptionsBloc, SubscriptionsState>(
      listener: (context, state) {
        if (state is SubscriptionsFailure) {
          showToast(fToast, state.error, Icons.error);
        }
      },
      builder: (context, state) {
        if (state is SubscriptionsLoading) {
          return const Loader();
        }

        if (state is SubscriptionsLoadedSuccess) {
          final pagedSubscriptions = state.pagedSubscriptions;

          final subscriptions = pagedSubscriptions.items;
          final hasNextPage = pagedSubscriptions.hasNextPage;

          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount, // number of columns
              crossAxisSpacing: 8, // Space between columns
              mainAxisSpacing: 8, // Space between rows
              childAspectRatio:
                  aspectRatio, // Adjust aspect ratio to control card's size
            ),
            itemCount: subscriptions.length + 1,
            itemBuilder: (context, index) {
              if (index == subscriptions.length) {
                return CalendarLoadMoreButton(
                  onLoadMore: () {},
                  canLoadMore: hasNextPage,
                );
              }

              final subscription = subscriptions[index];

              final icon = getImagePath(subscription.company) ??
                  "assets/images/google_logo.png";

              return SubscriptionCard(
                name: subscription.name,
                icon: icon,
                amount: subscription.amount.toStringAsFixed(2),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
