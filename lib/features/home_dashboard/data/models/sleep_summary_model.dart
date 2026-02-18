import '../../domain/entities/sleep_summary.dart';

/// Data model for SleepSummary
class SleepSummaryModel extends SleepSummary {
  const SleepSummaryModel({
    required super.averageSleepDuration,
    required super.sleepScore,
    super.lastSleepDate,
    required super.hasActiveAlarm,
    required super.totalSleepRecords,
    required super.longestSleep,
    required super.shortestSleep,
  });

  /// Create model from entity
  factory SleepSummaryModel.fromEntity(SleepSummary entity) {
    return SleepSummaryModel(
      averageSleepDuration: entity.averageSleepDuration,
      sleepScore: entity.sleepScore,
      lastSleepDate: entity.lastSleepDate,
      hasActiveAlarm: entity.hasActiveAlarm,
      totalSleepRecords: entity.totalSleepRecords,
      longestSleep: entity.longestSleep,
      shortestSleep: entity.shortestSleep,
    );
  }

  /// Create model from JSON
  factory SleepSummaryModel.fromJson(Map<String, dynamic> json) {
    return SleepSummaryModel(
      averageSleepDuration:
          Duration(minutes: json['averageSleepDurationMinutes'] as int),
      sleepScore: json['sleepScore'] as int,
      lastSleepDate: json['lastSleepDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['lastSleepDate'] as int)
          : null,
      hasActiveAlarm: json['hasActiveAlarm'] as bool,
      totalSleepRecords: json['totalSleepRecords'] as int,
      longestSleep: Duration(minutes: json['longestSleepMinutes'] as int),
      shortestSleep: Duration(minutes: json['shortestSleepMinutes'] as int),
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'averageSleepDurationMinutes': averageSleepDuration.inMinutes,
      'sleepScore': sleepScore,
      'lastSleepDate': lastSleepDate?.millisecondsSinceEpoch,
      'hasActiveAlarm': hasActiveAlarm,
      'totalSleepRecords': totalSleepRecords,
      'longestSleepMinutes': longestSleep.inMinutes,
      'shortestSleepMinutes': shortestSleep.inMinutes,
    };
  }
}
