import 'package:fintrack_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fintrack_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fintrack_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fintrack_app/features/auth/domain/usecases/user_login.dart';
import 'package:fintrack_app/features/auth/domain/usecases/user_register.dart';
import 'package:get_it/get_it.dart';

final GetIt serviceLocator = GetIt.instance;

void initDependencies() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));
  serviceLocator.registerFactory(() => UserRegister(serviceLocator()));
}
