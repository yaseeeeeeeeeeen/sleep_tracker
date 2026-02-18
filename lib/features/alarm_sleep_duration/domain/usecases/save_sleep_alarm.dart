import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/sleep_alarm.dart';
import '../repositories/alarm_repository.dart';

/// Use case for saving a sleep alarm
class SaveSleepAlarm implements UseCase<SleepAlarm, SaveAlarmParams> {
  final AlarmRepository repository;

  SaveSleepAlarm(this.repository);

  @override
  Future<Either<Failure, SleepAlarm>> call(SaveAlarmParams params) async {
    // Validate sleep duration (1-12 hours)
    if (params.alarm.sleepDuration != null) {
      final hours = params.alarm.sleepDuration!.inHours;
      if (hours < 1 || hours > 12) {
        return Left(DatabaseFailure(
          message: 'Sleep duration must be between 1 and 12 hours',
          statusCode: 400,
        ));
      }
    }

    // Deactivate all other alarms before saving new one
    await repository.deactivateAllAlarms();

    return await repository.saveAlarm(params.alarm);
  }
}

class SaveAlarmParams extends Equatable {
  final SleepAlarm alarm;

  const SaveAlarmParams({required this.alarm});

  @override
  List<Object?> get props => [alarm];
}
