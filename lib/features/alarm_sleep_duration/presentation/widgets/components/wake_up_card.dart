import 'package:flutter/material.dart';
import '../../../../../core/consts/color_manager.dart';
import '../../../../../core/utilities/time_calculator.dart';

class WakeUpCard extends StatelessWidget {
  final DateTime wakeUpTime;
  final Duration sleepDuration;

  const WakeUpCard({
    Key? key,
    required this.wakeUpTime,
    required this.sleepDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayLabel = TimeCalculator.getDayLabel(wakeUpTime);
    final formattedTime = TimeCalculator.formatTime(wakeUpTime);
    final formattedDuration = TimeCalculator.formatDuration(sleepDuration);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.bedtime,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WAKE UP TIME',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.grey.shade600,
                        letterSpacing: 1.2,
                      ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      formattedTime,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(width: 12),
                    // Tomorrow badge
                    if (dayLabel == 'Tomorrow')
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 10,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              dayLabel.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'We\'ll wake you up after exactly $formattedDuration of sleep.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade400,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
