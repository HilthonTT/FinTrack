import 'package:fintrack_app/core/usecase/usecase.dart';
import 'package:fintrack_app/features/settings/domain/entities/settings.dart';
import 'package:fintrack_app/features/settings/domain/enums/security_option.dart';
import 'package:fintrack_app/features/settings/domain/enums/sorting_option.dart';
import 'package:fintrack_app/features/settings/domain/usecases/get_settings.dart';
import 'package:fintrack_app/features/settings/domain/usecases/update_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

final class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettings getSettings;
  final UpdateSettings updateSettings;

  SettingsBloc({
    required this.getSettings,
    required this.updateSettings,
  }) : super(const SettingsInitial()) {
    on<SettingsEvent>((event, emit) {
      emit(SettingsLoading());
    });

    on<SettingsGetSettingsEvent>(_onGetSettings);
    on<SettingsUpdateSettingsEvent>(_onUpdateSettings);
  }

  Future<void> _onGetSettings(
    SettingsGetSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final query = const NoParams();

    final response = await getSettings(query);

    response.fold(
      (failure) => emit(SettingsFailure(failure.message)),
      (settings) => emit(SettingsSuccess(settings)),
    );
  }

  Future<void> _onUpdateSettings(
    SettingsUpdateSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final command = UpdateSettingsCommand(
      securityOption: event.securityOption,
      sortingOption: event.sortingOption,
      currency: event.currency,
    );

    final response = await updateSettings(command);

    response.fold(
      (failure) => emit(SettingsFailure(failure.message)),
      (settings) => emit(SettingsSuccess(settings)),
    );
  }
}
