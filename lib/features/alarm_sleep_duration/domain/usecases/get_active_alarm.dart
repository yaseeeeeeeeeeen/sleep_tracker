import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/sleep_alarm.dart';
import '../repositories/alarm_repository.dart';

/// Use case for getting the active alarm
class GetActiveAlarm implements UseCase<SleepAlarm?, NoParams> {
  final AlarmRepository repository;

  GetActiveAlarm(this.repository);

  @override
  Future<Either<Failure, SleepAlarm?>> call(NoParams params) async {
    return await repository.getActiveAlarm();
  }
}
