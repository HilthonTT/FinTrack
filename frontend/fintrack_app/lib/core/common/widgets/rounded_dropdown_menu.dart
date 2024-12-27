import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class RoundedDropdownMenu<T> extends StatelessWidget {
  final T? selectedValue;
  final ValueChanged<T?>? onChanged;
  final String hint;
  final List<T> items;
  final String Function(T) itemToString;

  const RoundedDropdownMenu({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.hint,
    required this.items,
    required this.itemToString,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppPalette.gray60.withValues(alpha: .05),
        border: Border.all(color: AppPalette.gray70),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton<T>(
        dropdownColor: AppPalette.gray80,
        isExpanded: true,
        hint: Container(
          margin: EdgeInsets.only(top: 10.0, left: 8.0),
          child: Text(
            hint,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        value: selectedValue,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<T>>((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Container(
              margin: EdgeInsets.only(top: 10.0, left: 8.0),
              child: Text(
                itemToString(item),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
        icon: SizedBox.shrink(),
        underline: const SizedBox(),
      ),
    );
  }
}
