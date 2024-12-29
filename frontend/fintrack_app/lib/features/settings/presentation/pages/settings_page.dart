import 'package:fintrack_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fintrack_app/core/common/utils/toast_helper.dart';
import 'package:fintrack_app/core/common/widgets/loader.dart';
import 'package:fintrack_app/core/constants/currencies.dart';
import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:fintrack_app/features/auth/presentation/pages/login_page.dart';
import 'package:fintrack_app/features/settings/presentation/widgets/settings_content.dart';
import 'package:fintrack_app/features/settings/domain/entities/settings.dart';
import 'package:fintrack_app/features/settings/domain/enums/security_option.dart';
import 'package:fintrack_app/features/settings/domain/enums/sorting_option.dart';
import 'package:fintrack_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:fintrack_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

final class SettingsPage extends StatefulWidget {
  static MaterialPageRoute<SettingsPage> route() => MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<AppUserCubit>(context),
          child: const SettingsPage(),
        ),
      );

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

final class _SettingsPageState extends State<SettingsPage> {
  late FToast fToast;
  Settings? settings;

  bool isActive = false;

  void _updateSettingsCurrency(Settings settings, String? newCurrency) {
    if (newCurrency == null) {
      return;
    }

    if (!currencies.contains(newCurrency) || newCurrency.isEmpty) {
      showToast(fToast, "Currency not found", Icons.question_mark);
    }

    final event = SettingsUpdateSettingsEvent(
      securityOption: settings.securityOption,
      sortingOption: settings.sortingOption,
      currency: newCurrency,
    );

    context.read<SettingsBloc>().add(event);
  }

  void _updateSettingsSortingOption(
    Settings settings,
    SortingOption newSortingOption,
  ) {
    final event = SettingsUpdateSettingsEvent(
      securityOption: settings.securityOption,
      sortingOption: newSortingOption,
      currency: settings.currency,
    );

    context.read<SettingsBloc>().add(event);
  }

  void _updateSettingsSecurityOption(
    Settings settings,
    SecurityOption newSecurityOption,
  ) {
    final event = SettingsUpdateSettingsEvent(
      securityOption: newSecurityOption,
      sortingOption: settings.sortingOption,
      currency: settings.currency,
    );

    context.read<SettingsBloc>().add(event);
  }

  @override
  void initState() {
    super.initState();

    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);

    final event = SettingsGetSettingsEvent();

    context.read<SettingsBloc>().add(event);
  }

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
              child: BlocConsumer<SettingsBloc, SettingsState>(
                listener: (context, state) {
                  if (state is SettingsFailure) {
                    showToast(fToast, state.error, Icons.error);
                  }
                },
                builder: (context, state) {
                  if (state is SettingsLoading) {
                    return const Loader();
                  }

                  if (state is SettingsSuccess) {
                    final settings = state.settings;

                    return SettingsContent(
                      user: user,
                      settings: settings,
                      onCurrencyUpdated: (newCurrency) {
                        _updateSettingsCurrency(settings, newCurrency);
                      },
                      onSortingOptionUpdated: (newSortingOption) {
                        _updateSettingsSortingOption(
                          settings,
                          newSortingOption,
                        );
                      },
                      onSecurityOptionUpdated: (newSecurityOption) {
                        _updateSettingsSecurityOption(
                          settings,
                          newSecurityOption,
                        );
                      },
                      isActive: isActive,
                      onIsActiveChanged: (newVal) {
                        setState(() {
                          isActive = newVal;
                        });
                      },
                    );
                  }

                  return Center(
                    child: Text(
                      "No settings available",
                      style: TextStyle(color: AppPalette.white),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
