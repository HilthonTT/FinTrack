import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class IconItemRow extends StatelessWidget {
  final String title;
  final String icon;
  final String selectedValue;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  const IconItemRow({
    super.key,
    required this.title,
    required this.icon,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: <Widget>[
          Image.asset(
            icon,
            width: 20,
            height: 20,
            color: AppPalette.gray20,
          ),
          const SizedBox(width: 15),
          Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: AppPalette.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          DropdownButton<String>(
            value:
                options.contains(selectedValue) ? selectedValue : options.first,
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(
                  option,
                  style: TextStyle(
                    color: AppPalette.gray30,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            underline: const SizedBox(), // Removes default underline
            icon: const SizedBox.shrink(), // Removes the icon
          ),
          const SizedBox(width: 8),
          Image.asset(
            "assets/images/next.png",
            width: 12,
            height: 12,
            color: AppPalette.gray30,
          ),
        ],
      ),
    );
  }
}
