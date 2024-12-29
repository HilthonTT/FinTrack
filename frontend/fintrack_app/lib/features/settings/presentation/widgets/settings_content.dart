import 'package:fintrack_app/core/common/widgets/icon_item_row.dart';
import 'package:fintrack_app/core/common/widgets/icon_item_switch_row.dart';
import 'package:fintrack_app/core/constants/currencies.dart';
import 'package:fintrack_app/core/entities/user.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/settings/domain/entities/settings.dart';
import 'package:fintrack_app/features/settings/domain/enums/security_option.dart';
import 'package:fintrack_app/features/settings/domain/enums/sorting_option.dart';
import 'package:flutter/material.dart';

final class SettingsContent extends StatelessWidget {
  final User user;
  final Settings settings;
  final bool isActive;
  final Function(String? newCurrency) onCurrencyUpdated;
  final Function(bool newVal) onIsActiveChanged;
  final Function(SortingOption newSortingOption) onSortingOptionUpdated;
  final Function(SecurityOption securityOption) onSecurityOptionUpdated;

  const SettingsContent({
    super.key,
    required this.user,
    required this.settings,
    required this.onCurrencyUpdated,
    required this.isActive,
    required this.onIsActiveChanged,
    required this.onSortingOptionUpdated,
    required this.onSecurityOptionUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  padding: const EdgeInsets.all(16),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    "assets/images/back.png",
                    width: 25,
                    height: 25,
                    color: AppPalette.gray30,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Settings",
                  style: TextStyle(
                    color: AppPalette.gray30,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/u1.png",
              width: 70,
              height: 70,
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user.name,
              style: TextStyle(
                color: AppPalette.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user.email,
              style: TextStyle(
                color: AppPalette.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        _buildEditProfileButton(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader("General"),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppPalette.border.withValues(alpha: .1),
                  ),
                  color: AppPalette.gray60.withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: <Widget>[
                    IconItemRow(
                      title: "Security",
                      icon: "assets/images/face_id.png",
                      selectedValue:
                          _securityOptionToString(settings.securityOption),
                      options: ["FaceID", "PIN", "Password"],
                      onChanged: (value) {
                        if (value != null) {
                          onSecurityOptionUpdated(
                              _stringToSecurityOption(value));
                        }
                      },
                    ),
                    IconItemSwitchRow(
                      title: "iCloud Sync",
                      icon: "assets/images/icloud.png",
                      value: isActive,
                      didChange: onIsActiveChanged,
                    ),
                  ],
                ),
              ),
              _buildHeader("My subscription"),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppPalette.border.withValues(alpha: .1),
                  ),
                  color: AppPalette.gray60.withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    IconItemRow(
                      title: "Sorting",
                      icon: "assets/images/sorting.png",
                      selectedValue:
                          _sortingOptionToString(settings.sortingOption),
                      options: ["Date", "Name", "Amount (\$)"],
                      onChanged: (value) {
                        if (value != null) {
                          onSortingOptionUpdated(_stringToSortingOption(value));
                        }
                      },
                    ),
                    IconItemRow(
                      title: "Summary",
                      icon: "assets/images/chart.png",
                      selectedValue: "Average",
                      options: ["Average", "Total", "None"],
                      onChanged: (value) {},
                    ),
                    IconItemRow(
                      title: "Default currency",
                      icon: "assets/images/money.png",
                      selectedValue: settings.currency,
                      options: currencies,
                      onChanged: onCurrencyUpdated,
                    ),
                  ],
                ),
              ),
              _buildHeader("Appearances"),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppPalette.border.withValues(alpha: .1),
                  ),
                  color: AppPalette.gray60.withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: <Widget>[
                    IconItemRow(
                      title: "App icon",
                      icon: "assets/images/app_icon.png",
                      selectedValue: "Default",
                      options: ["Default", "Minimal", "Classic"],
                      onChanged: (value) {},
                    ),
                    IconItemRow(
                      title: "Theme",
                      icon: "assets/images/light_theme.png",
                      selectedValue: "Dark",
                      options: ["Light", "Dark", "System"],
                      onChanged: (value) {},
                    ),
                    IconItemRow(
                      title: "Font",
                      icon: "assets/images/font.png",
                      selectedValue: "Inter",
                      options: ["Inter", "Arial", "Roboto"],
                      onChanged: (value) {},
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildEditProfileButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppPalette.border.withValues(alpha: .15),
          ),
          color: AppPalette.gray60.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          "Edit profile",
          style: TextStyle(
            color: AppPalette.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          color: AppPalette.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _sortingOptionToString(SortingOption option) {
    switch (option) {
      case SortingOption.date:
        return "Date";
      case SortingOption.name:
        return "Name";
      case SortingOption.amount:
        return "Amount (\$)";
    }
  }

  SortingOption _stringToSortingOption(String value) {
    switch (value) {
      case "Date":
        return SortingOption.date;
      case "Name":
        return SortingOption.name;
      case "Amount (\$)":
        return SortingOption.amount;
      default:
        throw ArgumentError("Invalid sorting option string: $value");
    }
  }

  String _securityOptionToString(SecurityOption option) {
    switch (option) {
      case SecurityOption.faceId:
        return "FaceID";
      case SecurityOption.pin:
        return "PIN";
      case SecurityOption.password:
        return "Password";
    }
  }

  SecurityOption _stringToSecurityOption(String value) {
    switch (value) {
      case "FaceID":
        return SecurityOption.faceId;
      case "PIN":
        return SecurityOption.pin;
      case "Password":
        return SecurityOption.password;
      default:
        throw ArgumentError("Invalid security option string: $value");
    }
  }
}
