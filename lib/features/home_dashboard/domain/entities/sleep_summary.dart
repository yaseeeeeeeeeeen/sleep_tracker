import 'package:equatable/equatable.dart';

/// Domain entity for sleep summary statistics
class SleepSummary extends Equatable {
  final Duration averageSleepDuration;
  final int sleepScore; // 0-100
  final DateTime? lastSleepDate;
  final bool hasActiveAlarm;
  final int totalSleepRecords;
  final Duration longestSleep;
  final Duration shortestSleep;

  const SleepSummary({
    required this.averageSleepDuration,
    required this.sleepScore,
    this.lastSleepDate,
    required this.hasActiveAlarm,
    required this.totalSleepRecords,
    required this.longestSleep,
    required this.shortestSleep,
  });

  @override
  List<Object?> get props => [
        averageSleepDuration,
        sleepScore,
        lastSleepDate,
        hasActiveAlarm,
        totalSleepRecords,
        longestSleep,
        shortestSleep,
      ];

  /// Empty summary for when there's no data
  factory SleepSummary.empty() {
    return const SleepSummary(
      averageSleepDuration: Duration(hours: 0),
      sleepScore: 0,
      lastSleepDate: null,
      hasActiveAlarm: false,
      totalSleepRecords: 0,
      longestSleep: Duration(hours: 0),
      shortestSleep: Duration(hours: 0),
    );
  }
}
