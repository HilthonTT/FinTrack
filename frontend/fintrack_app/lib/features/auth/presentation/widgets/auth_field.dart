import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

final class AuthField extends StatelessWidget {
  static const emailRegex = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";

  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final bool isEmail;
  final IconData icon;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.icon,
    this.isPassword = false,
    this.isEmail = false,
  });

  String? handleValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "$hintText is required!";
    }

    if (isEmail && !RegExp(emailRegex).hasMatch(value)) {
      return "Please enter a valid email address.";
    }

    if (isPassword && value.length < 6) {
      return "Password must be at least 6 characters long.";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.done,
        obscureText: isPassword,
        cursorColor: AppPalette.secondary50,
        style: TextStyle(color: AppPalette.white),
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: AppPalette.white,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(icon, color: AppPalette.secondary),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppPalette.secondary),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppPalette.secondary.withValues(alpha: .7),
            ),
          ),
        ),
        validator: handleValidator,
      ),
    );
  }
}
