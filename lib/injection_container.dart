import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/interceptor/app_dio.dart';
import 'core/services/cache_services.dart';
import 'core/database/database.dart';
import 'features/alarm_sleep_duration/alarm_injection.dart';
import 'features/home_dashboard/dashboard_injection.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Database
  locator.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Blocs
  // TODO: Register BLoCs here

  // Repositories
  // TODO: Register repositories here

  // Use Cases
  // TODO: Register use cases here

  // Remote Sources
  // TODO: Register remote data sources here

  // Core Services
  locator.registerLazySingleton<CacheService>(() => CacheService());
  locator.registerLazySingleton<Dio>(() => Api().dio);

  // Feature modules
  setupAlarmDependencies();
  setupDashboardDependencies();
}
