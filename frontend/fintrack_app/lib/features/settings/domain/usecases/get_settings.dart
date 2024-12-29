import 'package:fintrack_app/core/errors/failure.dart';
import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/settings/domain/entities/settings.dart';
import 'package:fintrack_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:fpdart/fpdart.dart';

final class GetSettings implements UseCase<Settings, NoParams> {
  final SettingsRepository settingsRepository;

  const GetSettings(this.settingsRepository);

  @override
  Future<Either<Failure, Settings>> call(NoParams params) async {
    return await Future.value(settingsRepository.get());
  }
}
