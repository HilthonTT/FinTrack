import 'package:fintrack_app/features/settings/domain/entities/settings.dart';

final class SettingsModel extends Settings {
  const SettingsModel({
    required super.securityOption,
    required super.sortingOption,
    required super.currency,
  });
}
