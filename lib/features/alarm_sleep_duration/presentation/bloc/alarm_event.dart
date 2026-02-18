import 'package:equatable/equatable.dart';

/// Events for Alarm BLoC
abstract class AlarmEvent extends Equatable {
  const AlarmEvent();

  @override
  List<Object?> get props => [];
}

/// Load the active alarm
class LoadAlarmEvent extends AlarmEvent {
  const LoadAlarmEvent();
}

/// Update the sleep duration
class UpdateDurationEvent extends AlarmEvent {
  final Duration duration;

  const UpdateDurationEvent(this.duration);

  @override
  List<Object?> get props => [duration];
}

/// Save the alarm
class SaveAlarmEvent extends AlarmEvent {
  const SaveAlarmEvent();
}

/// Delete an alarm
class DeleteAlarmEvent extends AlarmEvent {
  final String alarmId;

  const DeleteAlarmEvent(this.alarmId);

  @override
  List<Object?> get props => [alarmId];
}
