import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/consts/color_manager.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';

const _sleepTips = [
  ('💤', 'Adults need 7–9 hours of sleep per night for optimal health.'),
  ('🌙', 'Consistent sleep schedules improve deep sleep quality.'),
  ('📵', 'Avoid screens 30 minutes before bed to fall asleep faster.'),
  ('☕', 'Caffeine stays in your system for up to 6 hours.'),
  ('🌡️', 'A cooler room (65–68°F) helps your body reach deep sleep.'),
  ('🧘', 'Deep breathing for 2 minutes before bed reduces sleep onset.'),
  ('🌅', 'Morning sunlight naturally resets your circadian rhythm.'),
  ('🚶', 'Even a 10-minute walk improves sleep quality significantly.'),
];

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen>
    with SingleTickerProviderStateMixin {
  int _tipIndex = 0;
  Timer? _tipTimer;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  void initState() {
    super.initState();
    _tipIndex = Random().nextInt(_sleepTips.length);
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();
    _tipTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      _fadeController.reverse().then((_) {
        if (mounted) {
          setState(() {
            _tipIndex = (_tipIndex + 1) % _sleepTips.length;
          });
          _fadeController.forward();
        }
      });
    });
  }

  @override
  void dispose() {
    _tipTimer?.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state is DashboardError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 64, color: AppColors.error),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(color: AppColors.error),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<DashboardBloc>()
                            .add(const RefreshDashboardEvent());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is DashboardLoaded) {
              return _buildDashboard(context, state);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, DashboardLoaded state) {
    final now = DateTime.now();
    final currentTime = DateFormat('HH:mm').format(now);
    final tip = _sleepTips[_tipIndex];

    // Responsive scaling
    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor = (screenHeight / 800).clamp(0.8, 1.0);

    return RefreshIndicator(
      onRefresh: () async {
        context.read<DashboardBloc>().add(const RefreshDashboardEvent());
      },
      color: AppColors.primary,
      backgroundColor: AppColors.surface,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(24 * scaleFactor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Large Time Display
            Center(
              child: Column(
                children: [
                  Text(
                    currentTime,
                    style: TextStyle(
                      fontSize: 72 * scaleFactor,
                      fontWeight: FontWeight.w900,
                      height: 1,
                      letterSpacing: -2,
                    ),
                  ),
                  SizedBox(height: 8 * scaleFactor),
                  Text(
                    '${_getGreeting()}, Alex',
                    style: TextStyle(
                      fontSize: 16 * scaleFactor,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24 * scaleFactor),

            // Rotating Sleep Tip
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.2),
                      AppColors.limeAccent.withValues(alpha: 0.06),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(tip.$1, style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        tip.$2,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Set Alarm Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  context.push('/alarm/mode');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.alarm_add, size: 24, color: Colors.white),
                    const SizedBox(width: 12),
                    Text(
                      'Set Alarm',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Sleep Streak Card
            _buildSleepStreakCard(context, state),
            const SizedBox(height: 16),

            // Last Night Card
            _buildLastNightCard(context, state),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepStreakCard(BuildContext context, DashboardLoaded state) {
    final streakDays = state.summary.totalSleepRecords;
    final weeklyStatus = [true, true, true, false, true, false, false];
    final weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sleep Streak',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.local_fire_department,
                color: AppColors.limeAccent,
                size: 32,
              ),
              const SizedBox(width: 8),
              Text(
                '$streakDays Days',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.limeAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              return Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: weeklyStatus[index]
                          ? AppColors.limeAccent
                          : Colors.grey.shade800,
                      shape: BoxShape.circle,
                    ),
                    child: weeklyStatus[index]
                        ? const Icon(Icons.check, color: Colors.black, size: 20)
                        : null,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    weekDays[index],
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildLastNightCard(BuildContext context, DashboardLoaded state) {
    final summary = state.summary;
    final lastNightDuration = summary.averageSleepDuration;
    final hours = lastNightDuration.inHours;
    final minutes = lastNightDuration.inMinutes.remainder(60);
    final progress = ((hours + minutes / 60) / 8.0).clamp(0.0, 1.0);
    final isIdeal = hours >= 7 && hours <= 9;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last Night',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${hours}h ',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                      TextSpan(
                        text: '${minutes}m',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isIdeal ? AppColors.success : AppColors.warning,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isIdeal ? 'Within ideal range' : 'Below ideal range',
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 8,
              backgroundColor: Colors.grey.shade800,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
