import 'package:equatable/equatable.dart';
import '../../domain/entities/sleep_alarm.dart';

/// States for Alarm BLoC
abstract class AlarmState extends Equatable {
  const AlarmState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class AlarmInitial extends AlarmState {
  const AlarmInitial();
}

/// Loading state
class AlarmLoading extends AlarmState {
  const AlarmLoading();
}

/// Loaded state with current duration
class AlarmLoaded extends AlarmState {
  final SleepAlarm? existingAlarm;
  final Duration currentDuration;
  final DateTime calculatedWakeTime;

  const AlarmLoaded({
    this.existingAlarm,
    required this.currentDuration,
    required this.calculatedWakeTime,
  });

  @override
  List<Object?> get props => [existingAlarm, currentDuration, calculatedWakeTime];

  AlarmLoaded copyWith({
    SleepAlarm? existingAlarm,
    Duration? currentDuration,
    DateTime? calculatedWakeTime,
  }) {
    return AlarmLoaded(
      existingAlarm: existingAlarm ?? this.existingAlarm,
      currentDuration: currentDuration ?? this.currentDuration,
      calculatedWakeTime: calculatedWakeTime ?? this.calculatedWakeTime,
    );
  }
}

/// Alarm saved successfully
class AlarmSaved extends AlarmState {
  final SleepAlarm alarm;

  const AlarmSaved(this.alarm);

  @override
  List<Object?> get props => [alarm];
}

/// Error state
class AlarmError extends AlarmState {
  final String message;

  const AlarmError(this.message);

  @override
  List<Object?> get props => [message];
}
