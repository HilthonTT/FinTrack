import 'package:fintrack_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fintrack_app/core/common/widgets/icon_item_row.dart';
import 'package:fintrack_app/core/common/widgets/icon_item_switch_row.dart';
import 'package:fintrack_app/core/constants/currencies.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class SettingsPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<AppUserCubit>(context),
          child: const SettingsPage(),
        ),
      );

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppUserCubit, AppUserState>(
        bloc: BlocProvider.of<AppUserCubit>(context),
        builder: (context, state) {
          if (state is! AppUserLoggedIn) {
            return const LoginPage();
          }

          final user = state.user;

          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
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
                              color: AppPalette.border.withOpacity(0.1),
                            ),
                            color: AppPalette.gray60.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: <Widget>[
                              IconItemRow(
                                title: "Security",
                                icon: "assets/images/face_id.png",
                                selectedValue: "FaceID",
                                options: ["FaceID", "PIN", "Password"],
                                onChanged: (value) {},
                              ),
                              IconItemSwitchRow(
                                title: "iCloud Sync",
                                icon: "assets/images/icloud.png",
                                value: isActive,
                                didChange: (newVal) {
                                  setState(() {
                                    isActive = newVal;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        _buildHeader("My subscription"),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppPalette.border.withOpacity(0.1),
                            ),
                            color: AppPalette.gray60.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              IconItemRow(
                                title: "Sorting",
                                icon: "assets/images/sorting.png",
                                selectedValue: "Date",
                                options: ["Date", "Name", "Priority"],
                                onChanged: (value) {},
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
                                selectedValue: "USD (\$)",
                                options: currencies,
                                onChanged: (newValue) {},
                              ),
                            ],
                          ),
                        ),
                        _buildHeader("Appearances"),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppPalette.border.withOpacity(0.1),
                            ),
                            color: AppPalette.gray60.withOpacity(0.2),
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
              ),
            ),
          );
        },
      ),
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
            color: AppPalette.border.withOpacity(0.15),
          ),
          color: AppPalette.gray60.withOpacity(0.2),
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
}
