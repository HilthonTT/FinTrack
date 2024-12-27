import 'package:fintrack_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fintrack_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fintrack_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fintrack_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fintrack_app/features/auth/domain/usecases/current_user.dart';
import 'package:fintrack_app/features/auth/domain/usecases/user_email_verify.dart';
import 'package:fintrack_app/features/auth/domain/usecases/user_login.dart';
import 'package:fintrack_app/features/auth/domain/usecases/user_register.dart';
import 'package:fintrack_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fintrack_app/features/expenses/data/datasources/expense_remote_data_source.dart';
import 'package:fintrack_app/features/expenses/data/repositories/expense_repository_impl.dart';
import 'package:fintrack_app/features/expenses/domain/repositories/expense_repository.dart';
import 'package:fintrack_app/features/expenses/domain/usecases/create_expense.dart';
import 'package:fintrack_app/features/expenses/domain/usecases/delete_expense.dart';
import 'package:fintrack_app/features/expenses/domain/usecases/get_expense_by_id.dart';
import 'package:fintrack_app/features/expenses/domain/usecases/get_expenses.dart';
import 'package:fintrack_app/features/expenses/domain/usecases/update_expense.dart';
import 'package:fintrack_app/features/expenses/presentation/bloc/expenses_bloc.dart';
import 'package:fintrack_app/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:fintrack_app/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:fintrack_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initServices();

  _initAuth();
  _initExpenses();
  _initSettings();
}

Future<void> _initServices() async {
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));
  serviceLocator.registerFactory(() => UserRegister(serviceLocator()));
  serviceLocator.registerFactory(() => UserEmailVerify(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userRegister: serviceLocator(),
      userLogin: serviceLocator(),
      appUserCubit: serviceLocator(),
      userEmailVerify: serviceLocator(),
      currentUser: serviceLocator(),
    ),
  );
}

void _initExpenses() {
  serviceLocator.registerFactory<ExpenseRemoteDataSource>(
    () => ExpenseRemoteDataSourceImpl(),
  );

  serviceLocator.registerFactory<ExpenseRepository>(
    () => ExpenseRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(() => CreateExpense(serviceLocator()));
  serviceLocator.registerFactory(() => UpdateExpense(serviceLocator()));
  serviceLocator.registerFactory(() => DeleteExpense(serviceLocator()));
  serviceLocator.registerFactory(() => GetExpenseById(serviceLocator()));
  serviceLocator.registerFactory(() => GetExpenses(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => ExpensesBloc(
      createExpense: serviceLocator(),
      deleteExpense: serviceLocator(),
      getExpenseById: serviceLocator(),
      getExpenses: serviceLocator(),
      updateExpense: serviceLocator(),
    ),
  );
}

void _initSettings() {
  serviceLocator.registerLazySingleton(() => Hive.box(name: "Settings"));

  serviceLocator.registerFactory<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<SettingsRepository>(
    () => SettingsRepositoryImpl(serviceLocator()),
  );
}
