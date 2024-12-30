import 'package:fintrack_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fintrack_app/core/network/connection_checker.dart';
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
import 'package:fintrack_app/features/settings/domain/usecases/get_settings.dart';
import 'package:fintrack_app/features/settings/domain/usecases/update_settings.dart';
import 'package:fintrack_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:fintrack_app/features/subscriptions/data/datasources/subscription_remote_datasource.dart';
import 'package:fintrack_app/features/subscriptions/data/repositories/subscription_repository_impl.dart';
import 'package:fintrack_app/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:fintrack_app/features/subscriptions/domain/usecases/cancel_subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/usecases/create_subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/usecases/delete_subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/usecases/get_by_id_subscription.dart';
import 'package:fintrack_app/features/subscriptions/domain/usecases/get_subscriptions.dart';
import 'package:fintrack_app/features/subscriptions/domain/usecases/update_subscription.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initServices();

  _initAuth();
  _initExpenses();
  _initSettings();
  _initSubscriptions();
}

Future<void> _initServices() async {
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerFactory(() => InternetConnection());

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
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
    () => ExpenseRepositoryImpl(serviceLocator(), serviceLocator()),
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

  serviceLocator.registerFactory(() => GetSettings(serviceLocator()));
  serviceLocator.registerFactory(() => UpdateSettings(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => SettingsBloc(
      getSettings: serviceLocator(),
      updateSettings: serviceLocator(),
    ),
  );
}

void _initSubscriptions() {
  serviceLocator.registerFactory<SubscriptionRemoteDatasource>(
    () => SubscriptionRemoteDatasourceImpl(),
  );

  serviceLocator.registerFactory<SubscriptionRepository>(
    () => SubscriptionRepositoryImpl(serviceLocator(), serviceLocator()),
  );

  serviceLocator.registerFactory(() => CancelSubscription(serviceLocator()));
  serviceLocator.registerFactory(() => CreateSubscription(serviceLocator()));
  serviceLocator.registerFactory(() => DeleteSubscription(serviceLocator()));
  serviceLocator.registerFactory(() => GetByIdSubscription(serviceLocator()));
  serviceLocator.registerFactory(() => GetSubscriptions(serviceLocator()));
  serviceLocator.registerFactory(() => UpdateSubscription(serviceLocator()));
}
