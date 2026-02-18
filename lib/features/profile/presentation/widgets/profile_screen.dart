import 'package:flutter/material.dart';
import '../../../../core/consts/color_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double _sleepGoal = 8.0;
  TimeOfDay _bedtimeTime = const TimeOfDay(hour: 22, minute: 0);
  bool _isReminderEnabled = true;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _bedtimeTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: AppColors.surface,
              onSurface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _bedtimeTime) {
      setState(() {
        _bedtimeTime = picked;
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor = (screenHeight / 800).clamp(0.8, 1.0);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: 24, vertical: 10 * scaleFactor),
          child: Column(
            children: [
              SizedBox(height: 20 * scaleFactor),
              // Circular Profile Image with Rings
              _buildProfileHeader(scaleFactor),
              SizedBox(height: 32 * scaleFactor),

              // Main Stats Card (Avg. Duration)
              _buildMainStatsCard(scaleFactor),
              SizedBox(height: 16 * scaleFactor),

              // Mini Stats (Streak & Total)
              Row(
                children: [
                  Expanded(
                      child: _buildMiniStatCard(
                          'Best Streak',
                          '12 Days',
                          Icons.local_fire_department_rounded,
                          AppColors.limeAccent,
                          scaleFactor)),
                  SizedBox(width: 16 * scaleFactor),
                  Expanded(
                      child: _buildMiniStatCard(
                          'Total Nights',
                          '148',
                          Icons.nightlight_round_rounded,
                          AppColors.primary,
                          scaleFactor)),
                ],
              ),
              SizedBox(height: 32 * scaleFactor),

              // Preferences Section
              _buildSectionHeader('Preferences', scaleFactor),
              SizedBox(height: 16 * scaleFactor),

              // Goal Slider Card
              _buildGoalSliderCard(scaleFactor),
              SizedBox(height: 12 * scaleFactor),

              // Wake Up Sound
              _buildPreferenceActionCard('Wake Up Sound', 'Morning Mist',
                  Icons.music_note_rounded, scaleFactor),
              SizedBox(height: 12 * scaleFactor),

              // Bedtime Reminder
              _buildPreferenceSwitchCard(
                'Bedtime Reminder',
                _formatTime(_bedtimeTime),
                Icons.notifications_rounded,
                _isReminderEnabled,
                scaleFactor,
                onTap: () => _selectTime(context),
                onChanged: (value) {
                  setState(() {
                    _isReminderEnabled = value;
                  });
                },
              ),
              SizedBox(height: 32 * scaleFactor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(double scaleFactor) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Outer Glow/Ring
            Container(
              width: 160 * scaleFactor,
              height: 160 * scaleFactor,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Gradient Border Ring
            Container(
              width: 130 * scaleFactor,
              height: 130 * scaleFactor,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const SweepGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.info,
                    AppColors.primary,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundDark,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withValues(alpha: 0.9),
                      child: Icon(Icons.person_outline_rounded,
                          size: 60 * scaleFactor, color: Colors.grey.shade400),
                    ),
                  ),
                ),
              ),
            ),
            // Edit Button overlay
            Positioned(
              bottom: 5 * scaleFactor,
              right: 5 * scaleFactor,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: Icon(Icons.edit_rounded,
                    size: 16 * scaleFactor, color: AppColors.primary),
              ),
            ),
          ],
        ),
        SizedBox(height: 24 * scaleFactor),
        Text(
          'Your Sleep Profile',
          style: TextStyle(
            fontSize: 28 * scaleFactor,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 8 * scaleFactor),
        Text(
          'Tracking consistency since 2023',
          style: TextStyle(
            fontSize: 14 * scaleFactor,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  Widget _buildMainStatsCard(double scaleFactor) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Avg. Duration',
                style: TextStyle(
                  fontSize: 13 * scaleFactor,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade500,
                ),
              ),
              SizedBox(height: 4 * scaleFactor),
              Text(
                '7h 42m',
                style: TextStyle(
                  fontSize: 32 * scaleFactor,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.access_time_filled_rounded,
                color: AppColors.primary, size: 32 * scaleFactor),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStatCard(String label, String value, IconData icon,
      Color iconColor, double scaleFactor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12 * scaleFactor,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade500,
                ),
              ),
              Icon(icon, color: iconColor, size: 20 * scaleFactor),
            ],
          ),
          SizedBox(height: 16 * scaleFactor),
          Text(
            value,
            style: TextStyle(
              fontSize: 22 * scaleFactor,
              fontWeight: FontWeight.w900,
              color: iconColor == AppColors.limeAccent
                  ? AppColors.limeAccent
                  : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, double scaleFactor) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20 * scaleFactor,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildGoalSliderCard(double scaleFactor) {
    const double minGoal = 5.0;
    const double maxGoal = 10.0;
    final double percentage =
        ((_sleepGoal - minGoal) / (maxGoal - minGoal)).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.flag_rounded, color: AppColors.primary),
              ),
              const SizedBox(width: 16),
              Text(
                'Sleep Goal',
                style: TextStyle(
                  fontSize: 16 * scaleFactor,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                '${_sleepGoal.toStringAsFixed(1)} hrs',
                style: TextStyle(
                  fontSize: 16 * scaleFactor,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 24 * scaleFactor),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              return GestureDetector(
                onHorizontalDragUpdate: (details) {
                  final double localX = details.localPosition.dx;
                  final double newPercentage = (localX / width).clamp(0.0, 1.0);
                  setState(() {
                    _sleepGoal =
                        minGoal + (newPercentage * (maxGoal - minGoal));
                  });
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Background track
                    Container(
                      height: 8 * scaleFactor,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    // Active track
                    Container(
                      height: 8 * scaleFactor,
                      width: width * percentage,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    // Knob
                    Positioned(
                      left: (width * percentage) - (12 * scaleFactor),
                      top: -8 * scaleFactor,
                      child: Container(
                        width: 24 * scaleFactor,
                        height: 24 * scaleFactor,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.primary, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 12 * scaleFactor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['5h', '6h', '8h', '10h'].map((t) {
              final double hourVal = double.parse(t.replaceAll('h', ''));
              final bool isSelected = (_sleepGoal - hourVal).abs() < 0.25;
              return Text(
                t,
                style: TextStyle(
                  fontSize: 12 * scaleFactor,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                  color: isSelected ? AppColors.primary : Colors.grey.shade600,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceActionCard(
      String title, String subtitle, IconData icon, double scaleFactor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16 * scaleFactor,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13 * scaleFactor,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: Colors.grey.shade700),
        ],
      ),
    );
  }

  Widget _buildPreferenceSwitchCard(String title, String subtitle,
      IconData icon, bool value, double scaleFactor,
      {VoidCallback? onTap, ValueChanged<bool>? onChanged}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16 * scaleFactor,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13 * scaleFactor,
                      color: AppColors.primary, // Highlight the clickable time
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale: 0.8 * scaleFactor,
              child: Switch(
                value: value,
                onChanged: onChanged,
                activeColor: Colors.white,
                activeTrackColor: AppColors.limeAccent,
                inactiveThumbColor: Colors.grey.shade400,
                inactiveTrackColor: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
