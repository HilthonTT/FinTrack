import 'package:fintrack_app/features/budgets/presentation/widgets/budget_row.dart';
import 'package:flutter/material.dart';

final class BudgetList extends StatelessWidget {
  BudgetList({super.key});

  final List<Map<String, dynamic>> budgets = [
    {
      "id": "123",
      "userId": "user1",
      "name": "Monthly Rent",
      "amount": 400.99,
      "spent": 25.35,
      "amountLeft": 375.64,
      "startDate": "2024-01-01",
      "endDate": "2024-01-31",
      "createdOnUtc": "2023-12-01T10:00:00Z",
      "modifiedOnUtc": "2023-12-10T15:00:00Z"
    },
    {
      "id": "124",
      "userId": "user2",
      "name": "Vacation Fund",
      "amount": 1500.50,
      "spent": 450.75,
      "amountLeft": 1049.75,
      "startDate": "2024-01-01",
      "endDate": "2024-02-01",
      "createdOnUtc": "2023-12-02T11:00:00Z",
      "modifiedOnUtc": "2023-12-11T16:00:00Z"
    },
    {
      "id": "125",
      "userId": "user3",
      "name": "Emergency Fund",
      "amount": 800.00,
      "spent": 200.00,
      "amountLeft": 600.00,
      "startDate": "2024-01-15",
      "endDate": "2024-02-15",
      "createdOnUtc": "2023-12-05T12:00:00Z",
      "modifiedOnUtc": "2023-12-12T17:00:00Z"
    },
    {
      "id": "126",
      "userId": "user4",
      "name": "Car Maintenance",
      "amount": 1000.00,
      "spent": 750.00,
      "amountLeft": 250.00,
      "startDate": "2024-02-01",
      "endDate": "2024-02-28",
      "createdOnUtc": "2023-12-10T13:00:00Z",
      "modifiedOnUtc": "2023-12-20T18:00:00Z"
    },
    {
      "id": "127",
      "userId": "user5",
      "name": "Holiday Shopping",
      "amount": 250.75,
      "spent": 50.25,
      "amountLeft": 200.50,
      "startDate": "2024-01-10",
      "endDate": "2024-01-30",
      "createdOnUtc": "2023-12-08T14:00:00Z",
      "modifiedOnUtc": null
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: budgets.length,
      itemBuilder: (context, index) {
        final budget = budgets[index];

        return BudgetRow(
          id: budget["id"],
          name: budget["name"],
          userId: budget["userId"],
          amount: budget["amount"],
          amountLeft: budget["amountLeft"],
          spent: budget["spent"],
          startDate: budget["startDate"],
          endDate: budget["endDate"],
          createdOnUtc: DateTime.parse(budget["createdOnUtc"]),
          modifiedOnUtc: budget["modifiedOnUtc"] != null
              ? DateTime.parse(budget["modifiedOnUtc"])
              : null,
        );
      },
    );
  }
}
