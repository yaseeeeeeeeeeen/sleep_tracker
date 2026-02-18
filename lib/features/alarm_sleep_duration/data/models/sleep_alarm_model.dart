import '../../domain/entities/sleep_alarm.dart';

/// Data model for SleepAlarm that extends the domain entity
class SleepAlarmModel extends SleepAlarm {
  const SleepAlarmModel({
    required super.id,
    required super.type,
    super.sleepDuration,
    required super.wakeUpTime,
    required super.isActive,
    required super.createdAt,
  });

  /// Create model from domain entity
  factory SleepAlarmModel.fromEntity(SleepAlarm entity) {
    return SleepAlarmModel(
      id: entity.id,
      type: entity.type,
      sleepDuration: entity.sleepDuration,
      wakeUpTime: entity.wakeUpTime,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
    );
  }

  /// Create model from JSON
  factory SleepAlarmModel.fromJson(Map<String, dynamic> json) {
    return SleepAlarmModel(
      id: json['id'] as String,
      type: AlarmType.values.firstWhere(
        (e) => e.toString() == 'AlarmType.${json['type']}',
      ),
      sleepDuration: json['sleepDurationMinutes'] != null
          ? Duration(minutes: json['sleepDurationMinutes'] as int)
          : null,
      wakeUpTime: DateTime.fromMillisecondsSinceEpoch(json['wakeUpTime'] as int),
      isActive: json['isActive'] as bool,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'sleepDurationMinutes': sleepDuration?.inMinutes,
      'wakeUpTime': wakeUpTime.millisecondsSinceEpoch,
      'isActive': isActive,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  /// Create model from Drift database row
  factory SleepAlarmModel.fromDrift(Map<String, dynamic> row) {
    return SleepAlarmModel(
      id: row['id'] as String,
      type: AlarmType.values.firstWhere(
        (e) => e.name == row['type'],
      ),
      sleepDuration: row['sleep_duration_minutes'] != null
          ? Duration(minutes: row['sleep_duration_minutes'] as int)
          : null,
      wakeUpTime: DateTime.fromMillisecondsSinceEpoch(row['wake_up_time'] as int),
      isActive: row['is_active'] == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(row['created_at'] as int),
    );
  }

  /// Convert model to Drift database row
  Map<String, dynamic> toDrift() {
    return {
      'id': id,
      'type': type.name,
      'sleep_duration_minutes': sleepDuration?.inMinutes,
      'wake_up_time': wakeUpTime.millisecondsSinceEpoch,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }
}
