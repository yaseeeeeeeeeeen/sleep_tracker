import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/sleep_alarm.dart';

/// Repository interface for alarm operations
abstract class AlarmRepository {
  /// Save or update an alarm
  Future<Either<Failure, SleepAlarm>> saveAlarm(SleepAlarm alarm);
  
  /// Get the currently active alarm
  Future<Either<Failure, SleepAlarm?>> getActiveAlarm();
  
  /// Get all alarms
  Future<Either<Failure, List<SleepAlarm>>> getAllAlarms();
  
  /// Delete an alarm by ID
  Future<Either<Failure, void>> deleteAlarm(String id);
  
  /// Deactivate all alarms
  Future<Either<Failure, void>> deactivateAllAlarms();
}
