import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../alarm_sleep_duration/presentation/bloc/alarm_bloc.dart';
import '../../../alarm_sleep_duration/presentation/bloc/alarm_event.dart';
import '../../../alarm_sleep_duration/presentation/bloc/alarm_state.dart';
import '../../../alarm_sleep_duration/presentation/widgets/alarm_sleep_duration_screen.dart';
import '../../../alarm_fixed_time/presentation/widgets/alarm_fixed_time_screen.dart';

class AlarmModeSelectionScreen extends StatefulWidget {
  const AlarmModeSelectionScreen({super.key});

  @override
  State<AlarmModeSelectionScreen> createState() =>
      _AlarmModeSelectionScreenState();
}

class _AlarmModeSelectionScreenState extends State<AlarmModeSelectionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor = (screenHeight / 800).clamp(0.8, 1.0);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.fromLTRB(24, 16 * scaleFactor, 24, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: Icon(Icons.close_rounded,
                            color: Colors.white, size: 28 * scaleFactor),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.05),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      Text(
                        'Set Alarm',
                        style: TextStyle(
                          fontSize: 18 * scaleFactor,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                          width: 48 * scaleFactor), // Spacer to balance the 'X'
                    ],
                  ),
                  SizedBox(height: 24 * scaleFactor),
                  // Tab Switcher
                  Container(
                    height: 44 * scaleFactor,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey.shade400,
                      labelStyle: TextStyle(
                        fontSize: 14 * scaleFactor,
                        fontWeight: FontWeight.w600,
                      ),
                      tabs: const [
                        Tab(text: 'Sleep Duration'),
                        Tab(text: 'Fixed Time'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tab Content — swipe disabled
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  AlarmSleepDurationScreen(),
                  AlarmFixedTimeScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
