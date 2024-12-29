part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {
  const SettingsEvent();
}

final class SettingsGetSettingsEvent extends SettingsEvent {}

final class SettingsUpdateSettingsEvent extends SettingsEvent {
  final SecurityOption securityOption;
  final SortingOption sortingOption;
  final String currency;

  const SettingsUpdateSettingsEvent({
    required this.securityOption,
    required this.sortingOption,
    required this.currency,
  });
}
