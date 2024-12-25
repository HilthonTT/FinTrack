import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/cupertino.dart';

final class IconItemSwitchRow extends StatelessWidget {
  final String title;
  final String icon;
  final bool value;
  final Function(bool) didChange;

  const IconItemSwitchRow({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    required this.didChange,
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
            style: TextStyle(
              color: AppPalette.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 8),
          CupertinoSwitch(value: value, onChanged: didChange),
        ],
      ),
    );
  }
}
