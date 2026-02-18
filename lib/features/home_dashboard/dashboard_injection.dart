import 'package:get_it/get_it.dart';
import 'data/datasources/dashboard_local_datasource.dart';
import 'data/repositories/dashboard_repository_impl.dart';
import 'domain/repositories/dashboard_repository.dart';
import 'domain/usecases/get_sleep_summary.dart';
import 'presentation/bloc/dashboard_bloc.dart';

final locator = GetIt.instance;

void setupDashboardDependencies() {
  // Data sources
  locator.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSourceImpl(database: locator()),
  );

  // Repositories
  locator.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(localDataSource: locator()),
  );

  // Use cases
  locator.registerLazySingleton(() => GetSleepSummary(locator()));

  // BLoC
  locator.registerFactory(
    () => DashboardBloc(getSleepSummary: locator()),
  );
}
