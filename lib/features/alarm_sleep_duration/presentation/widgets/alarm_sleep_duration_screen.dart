import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/utilities/time_calculator.dart';
import '../bloc/alarm_bloc.dart';
import '../bloc/alarm_event.dart';
import '../bloc/alarm_state.dart';
import 'components/circular_dial.dart';
import 'components/wake_up_card.dart';

class AlarmSleepDurationScreen extends StatefulWidget {
  const AlarmSleepDurationScreen({Key? key}) : super(key: key);

  @override
  State<AlarmSleepDurationScreen> createState() =>
      _AlarmSleepDurationScreenState();
}

class _AlarmSleepDurationScreenState extends State<AlarmSleepDurationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlarmBloc, AlarmState>(
      listener: (context, state) {
        if (state is AlarmSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Alarm saved successfully!'),
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
      builder: (context, state) {
        if (state is AlarmLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }
        if (state is AlarmLoaded) {
          return _buildContent(context, state);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildContent(BuildContext context, AlarmLoaded state) {
    final isOptimal = TimeCalculator.isOptimalDuration(state.currentDuration);
    final hours = state.currentDuration.inHours;
    final minutes = state.currentDuration.inMinutes.remainder(60);

    // Responsive scaling
    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor = (screenHeight / 800).clamp(0.8, 1.0);
    final dialSize = 280 * scaleFactor;
    final innerCircleSize = 170 * scaleFactor;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                // Circular Dial
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30 * scaleFactor),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularDial(
                        size: dialSize,
                        currentDuration: state.currentDuration,
                        onDurationChanged: (duration) {
                          context
                              .read<AlarmBloc>()
                              .add(UpdateDurationEvent(duration));
                        },
                      ),
                      // Center Display
                      Container(
                        width: innerCircleSize,
                        height: innerCircleSize,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundDark,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.05),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 20 * scaleFactor,
                              spreadRadius: 5 * scaleFactor,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  hours.toString(),
                                  style: TextStyle(
                                    fontSize: 42 * scaleFactor,
                                    fontWeight: FontWeight.w900,
                                    height: 1,
                                  ),
                                ),
                                Text(
                                  'h',
                                  style: TextStyle(
                                    fontSize: 24 * scaleFactor,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                            if (minutes > 0)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    minutes.toString(),
                                    style: TextStyle(
                                      fontSize: 32 * scaleFactor,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade500,
                                      height: 1,
                                    ),
                                  ),
                                  Text(
                                    'm',
                                    style: TextStyle(
                                      fontSize: 18 * scaleFactor,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(height: 12 * scaleFactor),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10 * scaleFactor,
                                vertical: 4 * scaleFactor,
                              ),
                              decoration: BoxDecoration(
                                color: isOptimal
                                    ? AppColors.limeAccent
                                        .withValues(alpha: 0.1)
                                    : Colors.orange.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6 * scaleFactor,
                                    height: 6 * scaleFactor,
                                    decoration: BoxDecoration(
                                      color: isOptimal
                                          ? AppColors.limeAccent
                                          : Colors.orange,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 6 * scaleFactor),
                                  Text(
                                    isOptimal ? 'OPTIMAL' : 'ADJUST',
                                    style: TextStyle(
                                      fontSize: 10 * scaleFactor,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                      color: isOptimal
                                          ? AppColors.limeAccent
                                              .withValues(alpha: 0.9)
                                          : Colors.orange
                                              .withValues(alpha: 0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20 * scaleFactor),

                // Wake Up Card
                WakeUpCard(
                  wakeUpTime: state.calculatedWakeTime,
                  sleepDuration: state.currentDuration,
                ),
              ],
            ),
          ),
        ),

        // Fixed Save Button
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.read<AlarmBloc>().add(const SaveAlarmEvent());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.alarm_on, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'Save Alarm',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
