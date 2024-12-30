import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class RoundTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextAlign titleAlign;
  final bool obscureText;
  final String? hintText;

  const RoundTextField({
    super.key,
    required this.title,
    this.controller,
    this.keyboardType,
    this.titleAlign = TextAlign.left,
    this.obscureText = false,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                textAlign: titleAlign,
                style: TextStyle(
                  color: AppPalette.gray50,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 4),
        Container(
          height: 48,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: AppPalette.gray60.withValues(alpha: .05),
            border: Border.all(color: AppPalette.gray70),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
            cursorColor: AppPalette.secondary,
            style: TextStyle(
              color: AppPalette.white,
              fontWeight: FontWeight.w500,
            ),
            cursorErrorColor: AppPalette.secondary,
            controller: controller,
            decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              hintText: hintText,
            ),
            keyboardType: keyboardType,
            obscureText: obscureText,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (hintText != null) {
                if (value == null || value.isEmpty) {
                  return "$hintText is required!";
                }
              }

              if (value == null || value.isEmpty) {
                return "This field is required!";
              }

              return null;
            },
          ),
        )
      ],
    );
  }
}
