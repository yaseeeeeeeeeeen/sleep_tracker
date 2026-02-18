import 'package:drift/drift.dart';
import '../../../../core/database/database.dart';
import '../../../../core/error/exception.dart';
import '../models/sleep_alarm_model.dart';

/// Local data source for alarm operations using Drift
abstract class AlarmLocalDataSource {
  Future<SleepAlarmModel> saveAlarm(SleepAlarmModel alarm);
  Future<SleepAlarmModel?> getActiveAlarm();
  Future<List<SleepAlarmModel>> getAllAlarms();
  Future<void> deleteAlarm(String id);
  Future<void> deactivateAllAlarms();
}

class AlarmLocalDataSourceImpl implements AlarmLocalDataSource {
  final AppDatabase database;

  AlarmLocalDataSourceImpl({required this.database});

  @override
  Future<SleepAlarmModel> saveAlarm(SleepAlarmModel alarm) async {
    try {
      final companion = AlarmsCompanion(
        id: Value(alarm.id),
        type: Value(alarm.type.name),
        sleepDurationMinutes: Value(alarm.sleepDuration?.inMinutes),
        wakeUpTime: Value(alarm.wakeUpTime.millisecondsSinceEpoch),
        isActive: Value(alarm.isActive),
        createdAt: Value(alarm.createdAt.millisecondsSinceEpoch),
      );

      await database.into(database.alarms).insertOnConflictUpdate(companion);
      return alarm;
    } catch (e) {
      throw CacheException(
        message: 'Failed to save alarm: ${e.toString()}',
        statusCode: 500,
      );
    }
  }

  @override
  Future<SleepAlarmModel?> getActiveAlarm() async {
    try {
      final query = database.select(database.alarms)
        ..where((tbl) => tbl.isActive.equals(true))
        ..limit(1);

      final result = await query.getSingleOrNull();
      
      if (result == null) return null;

      return SleepAlarmModel.fromDrift({
        'id': result.id,
        'type': result.type,
        'sleep_duration_minutes': result.sleepDurationMinutes,
        'wake_up_time': result.wakeUpTime,
        'is_active': result.isActive ? 1 : 0,
        'created_at': result.createdAt,
      });
    } catch (e) {
      throw CacheException(
        message: 'Failed to get active alarm: ${e.toString()}',
        statusCode: 500,
      );
    }
  }

  @override
  Future<List<SleepAlarmModel>> getAllAlarms() async {
    try {
      final results = await database.select(database.alarms).get();
      
      return results.map((row) {
        return SleepAlarmModel.fromDrift({
          'id': row.id,
          'type': row.type,
          'sleep_duration_minutes': row.sleepDurationMinutes,
          'wake_up_time': row.wakeUpTime,
          'is_active': row.isActive ? 1 : 0,
          'created_at': row.createdAt,
        });
      }).toList();
    } catch (e) {
      throw CacheException(
        message: 'Failed to get all alarms: ${e.toString()}',
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> deleteAlarm(String id) async {
    try {
      await (database.delete(database.alarms)
            ..where((tbl) => tbl.id.equals(id)))
          .go();
    } catch (e) {
      throw CacheException(
        message: 'Failed to delete alarm: ${e.toString()}',
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> deactivateAllAlarms() async {
    try {
      await (database.update(database.alarms))
          .write(const AlarmsCompanion(isActive: Value(false)));
    } catch (e) {
      throw CacheException(
        message: 'Failed to deactivate alarms: ${e.toString()}',
        statusCode: 500,
      );
    }
  }
}
