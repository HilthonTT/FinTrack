import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final class EditableDateField extends StatefulWidget {
  final DateTime initialDate;
  final void Function(DateTime newDate) onDateChanged;

  const EditableDateField({
    super.key,
    required this.initialDate,
    required this.onDateChanged,
  });

  @override
  State<EditableDateField> createState() => _EditableDateFieldState();
}

final class _EditableDateFieldState extends State<EditableDateField> {
  late TextEditingController _controller;

  Future<void> _pickDate() async {
    // Show date picker and wait for the user to pick a date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != widget.initialDate) {
      // Update the date if it's changed
      widget.onDateChanged(pickedDate);
      _controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(widget.initialDate),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickDate,
      child: AbsorbPointer(
        child: Text(
          'Date: ${DateFormat('yyyy-MM-dd').format(widget.initialDate.toLocal())}',
          style: TextStyle(
            fontSize: 16,
            color: AppPalette.white,
          ),
        ),
      ),
    );
  }
}
