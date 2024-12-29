part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {
  const SettingsState();
}

final class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

final class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

final class SettingsFailure extends SettingsState {
  final String error;

  const SettingsFailure(this.error);
}

final class SettingsSuccess extends SettingsState {
  final Settings settings;

  const SettingsSuccess(this.settings);
}
