import 'package:fintrack_app/core/constants/currencies.dart';
import 'package:fintrack_app/features/settings/data/models/settings_model.dart';
import 'package:fintrack_app/features/settings/domain/enums/security_option.dart';
import 'package:fintrack_app/features/settings/domain/enums/sorting_option.dart';
import 'package:hive/hive.dart';

abstract interface class SettingsLocalDataSource {
  SettingsModel get();

  void update({
    required String currency,
    required SecurityOption securityOption,
    required SortingOption sortingOption,
  });
}

final class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  static const String settingsKey = "settings";

  final Box box;

  const SettingsLocalDataSourceImpl(this.box);

  @override
  SettingsModel get() {
    return _getOrCreate();
  }

  @override
  void update({
    required String currency,
    required SecurityOption securityOption,
    required SortingOption sortingOption,
  }) {
    final settingsData = box.get(settingsKey);

    if (settingsData == null) {
      final defaultSettings = SettingsModel(
        securityOption: securityOption,
        sortingOption: sortingOption,
        currency: currency,
      );

      box.put(settingsKey, {
        'securityOption': defaultSettings.securityOption.index,
        'sortingOption': defaultSettings.sortingOption.index,
        'currency': defaultSettings.currency,
      });
    } else {
      settingsData['securityOption'] = securityOption;
      settingsData['sortingOption'] = sortingOption;
      settingsData['currency'] = currency;

      box.put(settingsKey, settingsData);
    }
  }

  SettingsModel _getOrCreate() {
    final settingsData = box.get(settingsKey);

    if (settingsData != null) {
      return SettingsModel(
        securityOption: SecurityOption.values[settingsData['securityOption']],
        sortingOption: SortingOption.values[settingsData['sortingOption']],
        currency: settingsData['currency'],
      );
    }

    final defaultSettings = SettingsModel(
      securityOption: SecurityOption.password,
      sortingOption: SortingOption.date,
      currency: currencies[0],
    );

    box.put(settingsKey, {
      'securityOption': defaultSettings.securityOption.index,
      'sortingOption': defaultSettings.sortingOption.index,
      'currency': defaultSettings.currency,
    });

    return defaultSettings;
  }
}
