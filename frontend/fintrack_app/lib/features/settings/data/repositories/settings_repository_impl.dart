import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:fintrack_app/features/settings/data/models/settings_model.dart';
import 'package:fintrack_app/features/settings/domain/entities/settings.dart';
import 'package:fintrack_app/features/settings/domain/enums/security_option.dart';
import 'package:fintrack_app/features/settings/domain/enums/sorting_option.dart';
import 'package:fintrack_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:fpdart/fpdart.dart';

final class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource settingsLocalDataSource;

  const SettingsRepositoryImpl(this.settingsLocalDataSource);

  @override
  Either<Failure, Settings> get() {
    try {
      final settings = settingsLocalDataSource.get();

      return right(SettingsModel(
        securityOption: settings.securityOption,
        sortingOption: settings.sortingOption,
        currency: settings.currency,
      ));
    } catch (e) {
      return left(Failure("Failed to fetch settings"));
    }
  }

  @override
  Either<Failure, Unit> update({
    required SecurityOption securityOption,
    required SortingOption sortingOption,
    required String currency,
  }) {
    try {
      settingsLocalDataSource.update(
        currency: currency,
        securityOption: securityOption,
        sortingOption: sortingOption,
      );

      return right(unit);
    } catch (e) {
      return left(Failure("Failed to update settings"));
    }
  }
}
