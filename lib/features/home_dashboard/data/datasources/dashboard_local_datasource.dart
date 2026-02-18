import '../../../../core/database/database.dart';
import '../../../../core/error/exception.dart';
import '../models/sleep_summary_model.dart';

/// Local data source for dashboard operations
abstract class DashboardLocalDataSource {
  Future<SleepSummaryModel> getSleepSummary();
  Future<bool> hasActiveAlarm();
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final AppDatabase database;

  DashboardLocalDataSourceImpl({required this.database});

  @override
  Future<SleepSummaryModel> getSleepSummary() async {
    try {
      // Get all sleep records
      final sleepRecords = await (database.select(database.sleepRecords)).get();

      // Check for active alarm
      final activeAlarm = await (database.select(database.alarms)
            ..where((tbl) => tbl.isActive.equals(true)))
          .getSingleOrNull();

      if (sleepRecords.isEmpty) {
        return SleepSummaryModel(
          averageSleepDuration: const Duration(hours: 0),
          sleepScore: 0,
          lastSleepDate: null,
          hasActiveAlarm: activeAlarm != null,
          totalSleepRecords: 0,
          longestSleep: const Duration(hours: 0),
          shortestSleep: const Duration(hours: 0),
        );
      }

      // Calculate statistics
      int totalMinutes = 0;
      int totalScore = 0;
      int longestMinutes = 0;
      int shortestMinutes = sleepRecords.first.durationMinutes;
      DateTime? lastDate;

      for (final record in sleepRecords) {
        totalMinutes += record.durationMinutes;
        totalScore += record.qualityScore;

        if (record.durationMinutes > longestMinutes) {
          longestMinutes = record.durationMinutes;
        }
        if (record.durationMinutes < shortestMinutes) {
          shortestMinutes = record.durationMinutes;
        }

        final recordDate = DateTime.fromMillisecondsSinceEpoch(record.wakeTime);
        if (lastDate == null || recordDate.isAfter(lastDate)) {
          lastDate = recordDate;
        }
      }

      final avgMinutes = totalMinutes ~/ sleepRecords.length;
      final avgScore = totalScore ~/ sleepRecords.length;

      return SleepSummaryModel(
        averageSleepDuration: Duration(minutes: avgMinutes),
        sleepScore: avgScore,
        lastSleepDate: lastDate,
        hasActiveAlarm: activeAlarm != null,
        totalSleepRecords: sleepRecords.length,
        longestSleep: Duration(minutes: longestMinutes),
        shortestSleep: Duration(minutes: shortestMinutes),
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to get sleep summary: ${e.toString()}',
        statusCode: 500,
      );
    }
  }

  @override
  Future<bool> hasActiveAlarm() async {
    try {
      final activeAlarm = await (database.select(database.alarms)
            ..where((tbl) => tbl.isActive.equals(true)))
          .getSingleOrNull();

      return activeAlarm != null;
    } catch (e) {
      throw CacheException(
        message: 'Failed to check active alarm: ${e.toString()}',
        statusCode: 500,
      );
    }
  }
}
