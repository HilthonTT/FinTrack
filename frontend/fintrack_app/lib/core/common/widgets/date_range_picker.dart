import 'package:flutter/material.dart';

final class DateRangePicker extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Function(DateTime startDate, DateTime endDate) onDatesChanged;

  const DateRangePicker({
    super.key,
    required this.formKey,
    this.initialStartDate,
    this.initialEndDate,
    required this.onDatesChanged,
  });

  Future<void> _selectDate(
    BuildContext context,
    bool isStartDate,
    ValueNotifier<DateTime?> dateNotifier,
  ) async {
    final DateTime initialDate = dateNotifier.value ?? DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      dateNotifier.value = pickedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<DateTime?> startDateNotifier = ValueNotifier<DateTime?>(
      initialStartDate,
    );

    final ValueNotifier<DateTime?> endDateNotifier = ValueNotifier<DateTime?>(
      initialEndDate,
    );

    return Form(
      key: formKey,
      child: Column(
        children: [
          ValueListenableBuilder<DateTime?>(
            valueListenable: startDateNotifier,
            builder: (context, startDate, _) {
              return TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  hintText: startDate != null
                      ? '${startDate.toLocal()}'.split(' ')[0]
                      : 'Select a start date',
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                onTap: () => _selectDate(context, true, startDateNotifier),
                validator: (value) {
                  if (startDate == null) {
                    return 'Please select a start date.';
                  }

                  return null;
                },
              );
            },
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<DateTime?>(
            valueListenable: endDateNotifier,
            builder: (context, endDate, _) {
              return TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'End Date',
                  hintText: endDate != null
                      ? '${endDate.toLocal()}'.split(' ')[0]
                      : 'Select an end date',
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                onTap: () => _selectDate(context, false, endDateNotifier),
                validator: (value) {
                  final startDate = startDateNotifier.value;

                  if (endDate == null) {
                    return 'Please select an end date.';
                  }

                  if (startDate != null && endDate.isBefore(startDate)) {
                    return 'End date must be after start date.';
                  }

                  return null;
                },
              );
            },
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final startDate = startDateNotifier.value!;
                final endDate = endDateNotifier.value!;
                onDatesChanged(startDate, endDate);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
