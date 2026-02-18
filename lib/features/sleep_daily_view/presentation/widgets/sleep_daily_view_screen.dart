import 'package:flutter/material.dart';
import '../../../../core/consts/color_manager.dart';

class SleepDailyViewScreen extends StatelessWidget {
  const SleepDailyViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular Slept Hours & Trend
          _buildCircularScore(context),
          const SizedBox(height: 32),

          // Insight Card
          _buildInsightCard(),
          const SizedBox(height: 24),

          // Sleep Consistency
          _buildConsistencySection(),
          const SizedBox(height: 24),

          // Metrics Grid (2x2)
          _buildMetricsGrid(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCircularScore(BuildContext context) {
    // Simulated values for trend
    const isPositiveTrend = true;
    const trendText = '+30m vs avg';

    // Responsive scaling
    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor = (screenHeight / 800).clamp(0.8, 1.0);

    return Column(
      children: [
        SizedBox(
          height: 240 * scaleFactor,
          width: 240 * scaleFactor,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background Track
              SizedBox(
                height: 210 * scaleFactor,
                width: 210 * scaleFactor,
                child: CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: 20 * scaleFactor,
                  backgroundColor: Colors.transparent,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
              // Progress Value (Purple Ring)
              SizedBox(
                height: 210 * scaleFactor,
                width: 210 * scaleFactor,
                child: CircularProgressIndicator(
                  value: 0.85,
                  strokeWidth: 20 * scaleFactor,
                  strokeCap: StrokeCap.round,
                  backgroundColor: Colors.transparent,
                  color: AppColors.primary,
                ),
              ),

              // Content inside circle
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'TIME SLEPT',
                    style: TextStyle(
                      fontSize: 12 * scaleFactor,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.0 * scaleFactor,
                      color: AppColors.limeAccent.withValues(alpha: 0.7),
                    ),
                  ),
                  SizedBox(height: 8 * scaleFactor),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '7',
                        style: TextStyle(
                          fontSize: 64 * scaleFactor,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                      Text(
                        'h',
                        style: TextStyle(
                          fontSize: 24 * scaleFactor,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(width: 6 * scaleFactor),
                      Text(
                        '42',
                        style: TextStyle(
                          fontSize: 64 * scaleFactor,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                      Text(
                        'm',
                        style: TextStyle(
                          fontSize: 24 * scaleFactor,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6 * scaleFactor),
                  Text(
                    'Goal: 8h 00m',
                    style: TextStyle(
                      fontSize: 15 * scaleFactor,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12 * scaleFactor),
        // Trend Indicator with Positive/Negative Theme
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPositiveTrend
                  ? Icons.trending_up_rounded
                  : Icons.trending_down_rounded,
              color: isPositiveTrend ? AppColors.success : AppColors.error,
              size: 20 * scaleFactor,
            ),
            SizedBox(width: 6 * scaleFactor),
            Text(
              trendText,
              style: TextStyle(
                fontSize: 16 * scaleFactor,
                fontWeight: FontWeight.w700,
                color: isPositiveTrend ? AppColors.success : AppColors.error,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInsightCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome_rounded,
                color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Great job! Your consistency this week has improved your deep sleep by 12%.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.close_rounded, color: Colors.grey.shade600, size: 20),
        ],
      ),
    );
  }

  Widget _buildConsistencySection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sleep Consistency',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Details',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildBar('M', 0.6),
              _buildBar('T', 0.5),
              _buildBar('W', 0.7),
              _buildBar('T', 0.6),
              _buildBar('F', 0.9, isSelected: true),
              _buildBar('S', 0.5),
              _buildBar('S', 0.4),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String day, double heightFactor, {bool isSelected = false}) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 4,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 60 * heightFactor,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          day,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
            color: isSelected ? Colors.white : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: [
        _buildMetricCard(
          'Deep Sleep',
          '1h 20m',
          '18% of total',
          Icons.nights_stay_rounded,
          AppColors.primary,
          progress: 0.18,
        ),
        _buildMetricCard(
          'Time Awake',
          '35m',
          '5m vs avg',
          Icons.wb_sunny_rounded,
          Colors.orangeAccent,
          isTrendDown: true,
          progress: 0.1,
        ),
        _buildMetricCard(
          'HR Dip',
          '12%',
          'Ideal is >10%',
          Icons.favorite_rounded,
          AppColors.error,
        ),
        _buildMetricCard(
          'Resp. Rate',
          '14 rpm',
          'Normal range',
          Icons.air_rounded,
          Colors.tealAccent,
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String label,
    String value,
    String subValue,
    IconData icon,
    Color color, {
    double? progress,
    bool isTrendDown = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              if (label == 'Time Awake') ...[
                Icon(Icons.trending_down,
                    color: AppColors.limeAccent, size: 12),
                const SizedBox(width: 4),
              ],
              Text(
                subValue,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: label == 'Time Awake'
                      ? AppColors.limeAccent
                      : Colors.grey.shade500,
                ),
              ),
            ],
          ),
          if (progress != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white.withValues(alpha: 0.05),
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
