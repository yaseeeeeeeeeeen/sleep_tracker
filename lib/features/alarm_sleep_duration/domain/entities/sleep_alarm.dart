import 'package:equatable/equatable.dart';

enum AlarmType {
  duration, // Sleep for X hours
  fixedTime, // Wake at specific time
}

/// Domain entity for sleep alarm
class SleepAlarm extends Equatable {
  final String id;
  final AlarmType type;
  final Duration? sleepDuration; // For duration-based alarms
  final DateTime wakeUpTime;
  final bool isActive;
  final DateTime createdAt;

  const SleepAlarm({
    required this.id,
    required this.type,
    this.sleepDuration,
    required this.wakeUpTime,
    required this.isActive,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        sleepDuration,
        wakeUpTime,
        isActive,
        createdAt,
      ];

  SleepAlarm copyWith({
    String? id,
    AlarmType? type,
    Duration? sleepDuration,
    DateTime? wakeUpTime,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return SleepAlarm(
      id: id ?? this.id,
      type: type ?? this.type,
      sleepDuration: sleepDuration ?? this.sleepDuration,
      wakeUpTime: wakeUpTime ?? this.wakeUpTime,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
