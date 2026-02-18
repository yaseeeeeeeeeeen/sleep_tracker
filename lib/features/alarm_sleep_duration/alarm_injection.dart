import 'package:get_it/get_it.dart';
import 'data/datasources/alarm_local_datasource.dart';
import 'data/repositories/alarm_repository_impl.dart';
import 'domain/repositories/alarm_repository.dart';
import 'domain/usecases/get_active_alarm.dart';
import 'domain/usecases/save_sleep_alarm.dart';
import 'presentation/bloc/alarm_bloc.dart';

final locator = GetIt.instance;

void setupAlarmDependencies() {
  // Data sources
  locator.registerLazySingleton<AlarmLocalDataSource>(
    () => AlarmLocalDataSourceImpl(database: locator()),
  );

  // Repositories
  locator.registerLazySingleton<AlarmRepository>(
    () => AlarmRepositoryImpl(localDataSource: locator()),
  );

  // Use cases
  locator.registerLazySingleton(() => GetActiveAlarm(locator()));
  locator.registerLazySingleton(() => SaveSleepAlarm(locator()));

  // BLoC
  locator.registerFactory(
    () => AlarmBloc(
      getActiveAlarm: locator(),
      saveSleepAlarm: locator(),
    ),
  );
}
