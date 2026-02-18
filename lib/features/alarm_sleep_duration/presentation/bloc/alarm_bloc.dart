import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/consts/app_constants.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utilities/time_calculator.dart';
import '../../domain/entities/sleep_alarm.dart';
import '../../domain/usecases/get_active_alarm.dart';
import '../../domain/usecases/save_sleep_alarm.dart';
import 'alarm_event.dart';
import 'alarm_state.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  final GetActiveAlarm getActiveAlarm;
  final SaveSleepAlarm saveSleepAlarm;

  AlarmBloc({
    required this.getActiveAlarm,
    required this.saveSleepAlarm,
  }) : super(const AlarmInitial()) {
    on<LoadAlarmEvent>(_onLoadAlarm);
    on<UpdateDurationEvent>(_onUpdateDuration);
    on<SaveAlarmEvent>(_onSaveAlarm);
  }

  Future<void> _onLoadAlarm(
    LoadAlarmEvent event,
    Emitter<AlarmState> emit,
  ) async {
    emit(const AlarmLoading());

    final result = await getActiveAlarm(NoParams());

    result.fold(
      (failure) {
        // If no alarm exists, start with default 8 hours
        final defaultDuration = const Duration(hours: SleepConstants.idealSleepHours);
        final wakeTime = TimeCalculator.calculateWakeUpTime(
          sleepDuration: defaultDuration,
        );
        emit(AlarmLoaded(
          currentDuration: defaultDuration,
          calculatedWakeTime: wakeTime,
        ));
      },
      (alarm) {
        if (alarm != null && alarm.sleepDuration != null) {
          emit(AlarmLoaded(
            existingAlarm: alarm,
            currentDuration: alarm.sleepDuration!,
            calculatedWakeTime: alarm.wakeUpTime,
          ));
        } else {
          // No existing alarm, use default
          final defaultDuration = const Duration(hours: SleepConstants.idealSleepHours);
          final wakeTime = TimeCalculator.calculateWakeUpTime(
            sleepDuration: defaultDuration,
          );
          emit(AlarmLoaded(
            currentDuration: defaultDuration,
            calculatedWakeTime: wakeTime,
          ));
        }
      },
    );
  }

  Future<void> _onUpdateDuration(
    UpdateDurationEvent event,
    Emitter<AlarmState> emit,
  ) async {
    if (state is AlarmLoaded) {
      final currentState = state as AlarmLoaded;
      final wakeTime = TimeCalculator.calculateWakeUpTime(
        sleepDuration: event.duration,
      );

      emit(currentState.copyWith(
        currentDuration: event.duration,
        calculatedWakeTime: wakeTime,
      ));
    }
  }

  Future<void> _onSaveAlarm(
    SaveAlarmEvent event,
    Emitter<AlarmState> emit,
  ) async {
    if (state is! AlarmLoaded) return;

    final currentState = state as AlarmLoaded;
    emit(const AlarmLoading());

    final alarm = SleepAlarm(
      id: currentState.existingAlarm?.id ?? const Uuid().v4(),
      type: AlarmType.duration,
      sleepDuration: currentState.currentDuration,
      wakeUpTime: currentState.calculatedWakeTime,
      isActive: true,
      createdAt: DateTime.now(),
    );

    final result = await saveSleepAlarm(SaveAlarmParams(alarm: alarm));

    result.fold(
      (failure) => emit(AlarmError(failure.message)),
      (savedAlarm) => emit(AlarmSaved(savedAlarm)),
    );
  }
}
