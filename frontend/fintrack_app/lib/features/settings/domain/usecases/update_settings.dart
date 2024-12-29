import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/settings/domain/entities/settings.dart';
import 'package:fintrack_app/features/settings/domain/enums/security_option.dart';
import 'package:fintrack_app/features/settings/domain/enums/sorting_option.dart';
import 'package:fintrack_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:fpdart/fpdart.dart';

final class UpdateSettings implements UseCase<Settings, UpdateSettingsCommand> {
  final SettingsRepository settingsRepository;

  const UpdateSettings(this.settingsRepository);

  @override
  Future<Either<Failure, Settings>> call(UpdateSettingsCommand params) async {
    return await Future.value(
      settingsRepository.update(
        securityOption: params.securityOption,
        sortingOption: params.sortingOption,
        currency: params.currency,
      ),
    );
  }
}

final class UpdateSettingsCommand {
  final SecurityOption securityOption;
  final SortingOption sortingOption;
  final String currency;

  const UpdateSettingsCommand({
    required this.securityOption,
    required this.sortingOption,
    required this.currency,
  });
}
