import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class BudgetRow extends StatelessWidget {
  final String id;
  final String name;
  final String userId;
  final double amount;
  final double amountLeft;
  final double spent;
  final String startDate;
  final String endDate;
  final DateTime createdOnUtc;
  final DateTime? modifiedOnUtc;

  const BudgetRow({
    super.key,
    required this.id,
    required this.name,
    required this.userId,
    required this.amount,
    required this.amountLeft,
    required this.spent,
    required this.startDate,
    required this.endDate,
    required this.createdOnUtc,
    this.modifiedOnUtc,
  });

  @override
  Widget build(BuildContext context) {
    final proVal = amountLeft / amount;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppPalette.border.withValues(alpha: .05),
            ),
            color: AppPalette.gray60.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      "assets/images/entertainment.png",
                      width: 30,
                      height: 30,
                      color: AppPalette.gray40,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: AppPalette.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$$amountLeft left to spend",
                          style: TextStyle(
                            color: AppPalette.gray30,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$$spent",
                        style: TextStyle(
                          color: AppPalette.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "of \$$amount",
                        style: TextStyle(
                          color: AppPalette.gray30,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              LinearProgressIndicator(
                backgroundColor: AppPalette.gray60,
                valueColor: AlwaysStoppedAnimation(AppPalette.primary10),
                minHeight: 3,
                value: proVal,
              )
            ],
          ),
        ),
      ),
    );
  }
}
