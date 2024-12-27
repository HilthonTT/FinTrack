import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/features/settings/domain/entities/settings.dart';
import 'package:fintrack_app/features/settings/domain/enums/security_option.dart';
import 'package:fintrack_app/features/settings/domain/enums/sorting_option.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class SettingsRepository {
  Either<Failure, Settings> get();

  Either<Failure, Unit> update({
    required SecurityOption securityOption,
    required SortingOption sortingOption,
    required String currency,
  });
}
