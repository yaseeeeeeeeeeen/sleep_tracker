import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../alarm_sleep_duration/presentation/bloc/alarm_bloc.dart';
import '../../../alarm_sleep_duration/presentation/bloc/alarm_event.dart';
import '../../../alarm_sleep_duration/presentation/bloc/alarm_state.dart';

class AlarmFixedTimeScreen extends StatefulWidget {
  const AlarmFixedTimeScreen({super.key});

  @override
  State<AlarmFixedTimeScreen> createState() => _AlarmFixedTimeScreenState();
}

class _AlarmFixedTimeScreenState extends State<AlarmFixedTimeScreen> {
  int _selectedHour = 7;
  int _selectedMinute = 30;
  int _selectedPeriod = 0; // 0 = AM, 1 = PM

  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    int hour = now.hour;
    _selectedMinute = now.minute;

    if (hour >= 12) {
      _selectedPeriod = 1; // PM
      if (hour > 12) hour -= 12;
    } else {
      _selectedPeriod = 0; // AM
      if (hour == 0) hour = 12;
    }
    _selectedHour = hour;

    _hourController =
        FixedExtentScrollController(initialItem: _selectedHour - 1);
    _minuteController =
        FixedExtentScrollController(initialItem: _selectedMinute);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor = (screenHeight / 800).clamp(0.8, 1.0);

    return BlocListener<AlarmBloc, AlarmState>(
      listener: (context, state) {
        if (state is AlarmSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Alarm set successfully!'),
              backgroundColor: AppColors.success,
            ),
          );
          context.pop();
        } else if (state is AlarmError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Column(
        children: [
          // Time Picker Container
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20 * scaleFactor),
              child: Column(
                children: [
                  SizedBox(height: 40 * scaleFactor),
                  // Time Picker Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Hour Picker
                      SizedBox(
                        width: 100 * scaleFactor,
                        height: 250 * scaleFactor,
                        child: CupertinoPicker(
                          scrollController: _hourController,
                          itemExtent: 80 * scaleFactor,
                          squeeze: 1.1,
                          diameterRatio: 1.5,
                          onSelectedItemChanged: (i) =>
                              setState(() => _selectedHour = i + 1),
                          selectionOverlay: const SizedBox.shrink(),
                          children: List.generate(12, (i) {
                            final h = i + 1;
                            final isSelected = _selectedHour == h;
                            return Center(
                              child: Text(
                                h.toString().padLeft(2, '0'),
                                style: TextStyle(
                                  fontSize: 64 * scaleFactor,
                                  fontWeight: FontWeight.w900,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.15),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      SizedBox(width: 8 * scaleFactor),
                      // Colon
                      Text(
                        ':',
                        style: TextStyle(
                          fontSize: 48 * scaleFactor,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      SizedBox(width: 8 * scaleFactor),

                      // Minute Picker
                      SizedBox(
                        width: 100 * scaleFactor,
                        height: 250 * scaleFactor,
                        child: CupertinoPicker(
                          scrollController: _minuteController,
                          itemExtent: 80 * scaleFactor,
                          squeeze: 1.1,
                          diameterRatio: 1.5,
                          onSelectedItemChanged: (i) =>
                              setState(() => _selectedMinute = i),
                          selectionOverlay: const SizedBox.shrink(),
                          children: List.generate(60, (i) {
                            final isSelected = _selectedMinute == i;
                            return Center(
                              child: Text(
                                i.toString().padLeft(2, '0'),
                                style: TextStyle(
                                  fontSize: 64 * scaleFactor,
                                  fontWeight: FontWeight.w900,
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.primary
                                          .withValues(alpha: 0.15),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40 * scaleFactor),

                  // AM/PM Selector
                  Container(
                    width: 180,
                    height: 56,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        _buildAmPmTab('AM', 0),
                        _buildAmPmTab('PM', 1),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Sleep Duration Info
                  _buildSleepDurationInfo(),
                ],
              ),
            ),
          ),

          // Fixed bottom button
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: SizedBox(
              width: double.infinity,
              height: 64,
              child: ElevatedButton(
                onPressed: _saveAlarm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  shadowColor: AppColors.primary.withValues(alpha: 0.4),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.alarm_add_rounded,
                        size: 26, color: Colors.white),
                    SizedBox(width: 12),
                    Text(
                      'Save Alarm',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmPmTab(String label, int index) {
    final isSelected = _selectedPeriod == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPeriod = index),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSleepDurationInfo() {
    final now = DateTime.now();
    int hour24 = _selectedHour;
    if (_selectedPeriod == 1 && _selectedHour != 12)
      hour24 = _selectedHour + 12;
    if (_selectedPeriod == 0 && _selectedHour == 12) hour24 = 0;

    final wakeTime =
        DateTime(now.year, now.month, now.day, hour24, _selectedMinute);
    final adjusted = wakeTime.isBefore(now) || wakeTime.isAtSameMomentAs(now)
        ? wakeTime.add(const Duration(days: 1))
        : wakeTime;

    final duration = adjusted.difference(now);
    final h = duration.inHours;
    final m = duration.inMinutes.remainder(60);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.nights_stay_rounded,
                color: AppColors.limeAccent, size: 20),
            const SizedBox(width: 10),
            RichText(
              text: TextSpan(
                text: 'Sleep duration: ',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: '${h}h ${m}m',
                    style: const TextStyle(
                      color: AppColors.limeAccent,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Wake up feeling refreshed and ready.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  void _saveAlarm() {
    final now = DateTime.now();
    int hour24 = _selectedHour;
    if (_selectedPeriod == 1 && _selectedHour != 12)
      hour24 = _selectedHour + 12;
    if (_selectedPeriod == 0 && _selectedHour == 12) hour24 = 0;

    final wakeTime =
        DateTime(now.year, now.month, now.day, hour24, _selectedMinute);
    final adjusted = wakeTime.isBefore(now) || wakeTime.isAtSameMomentAs(now)
        ? wakeTime.add(const Duration(days: 1))
        : wakeTime;

    context
        .read<AlarmBloc>()
        .add(UpdateDurationEvent(adjusted.difference(now)));
    context.read<AlarmBloc>().add(const SaveAlarmEvent());
  }
}
