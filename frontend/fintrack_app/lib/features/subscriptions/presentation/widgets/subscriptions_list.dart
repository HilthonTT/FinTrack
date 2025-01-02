import 'package:fintrack_app/core/common/utils/date.dart';
import 'package:fintrack_app/core/common/utils/image_path.dart';
import 'package:fintrack_app/core/common/utils/toast_helper.dart';
import 'package:fintrack_app/core/common/widgets/load_more_button.dart';
import 'package:fintrack_app/core/common/widgets/loader.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/subscriptions/presentation/bloc/subscriptions_bloc.dart';
import 'package:fintrack_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

final class SubscriptionsList extends StatefulWidget {
  const SubscriptionsList({super.key});

  @override
  State<SubscriptionsList> createState() => _SubscriptionsListState();
}

final class _SubscriptionsListState extends State<SubscriptionsList> {
  late FToast fToast;
  int take = 10;

  void loadMore() {
    setState(() {
      take += 10;
    });

    final event = GetSubscriptionsEvent(take: take);
    context.read<SubscriptionsBloc>().add(event);
  }

  @override
  void initState() {
    super.initState();

    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);

    final event = GetSubscriptionsEvent(take: take);
    context.read<SubscriptionsBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
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

          return Column(
            children: [
              ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: subscriptions.length,
                itemBuilder: (context, index) {
                  final subscription = subscriptions[index];

                  final imagePath = getImagePath(subscription.company);

                  void onTap() {}

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: onTap,
                      child: Container(
                        height: 64,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppPalette.border.withValues(alpha: .15),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            _getImage(imagePath),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                subscription.name,
                                style: TextStyle(
                                  color: AppPalette.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${subscription.amount.toStringAsPrecision(4)}",
                                  style: TextStyle(
                                    color: AppPalette.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  formatDate(
                                    subscription.createdOnUtc.toString(),
                                  ),
                                  style: TextStyle(
                                    color: AppPalette.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              LoadMoreButton(onPressed: loadMore, hasMore: hasNextPage),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _getImage(String? imagePath) {
    if (imagePath != null) {
      return Image.asset(
        imagePath,
        width: 40,
        height: 40,
        fit: BoxFit.contain,
      );
    }

    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppPalette.gray70.withValues(alpha: .5),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
    );
  }
}
