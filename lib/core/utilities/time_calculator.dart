import 'package:intl/intl.dart';

class TimeCalculator {
  /// Calculate wake-up time from current time and sleep duration
  static DateTime calculateWakeUpTime({
    DateTime? bedTime,
    required Duration sleepDuration,
  }) {
    final startTime = bedTime ?? DateTime.now();
    return startTime.add(sleepDuration);
  }
  
  /// Calculate sleep duration from bed time and wake time
  static Duration calculateSleepDuration({
    required DateTime bedTime,
    required DateTime wakeTime,
  }) {
    return wakeTime.difference(bedTime);
  }
  
  /// Format time as "HH:MM AM/PM"
  static String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }
  
  /// Format duration as "Xh Ym"
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    
    if (hours == 0) {
      return '${minutes}m';
    } else if (minutes == 0) {
      return '${hours}h';
    } else {
      return '${hours}h ${minutes}m';
    }
  }
  
  /// Check if sleep duration is in optimal range (7-9 hours)
  static bool isOptimalDuration(Duration duration) {
    final hours = duration.inHours;
    return hours >= 7 && hours <= 9;
  }
  
  /// Get sleep quality status based on duration
  static String getSleepQualityStatus(Duration duration) {
    final hours = duration.inHours;
    
    if (hours < 4) {
      return 'Critical';
    } else if (hours < 6) {
      return 'Poor';
    } else if (hours < 7) {
      return 'Fair';
    } else if (hours <= 9) {
      return 'Optimal';
    } else if (hours <= 10) {
      return 'Good';
    } else {
      return 'Excessive';
    }
  }
  
  /// Calculate sleep score (0-100) based on duration
  static int calculateSleepScore(Duration duration) {
    final hours = duration.inHours + (duration.inMinutes.remainder(60) / 60);
    
    if (hours < 4) {
      return (hours / 4 * 30).round();
    } else if (hours < 7) {
      return 30 + ((hours - 4) / 3 * 40).round();
    } else if (hours <= 8) {
      return 70 + ((hours - 7) * 30).round();
    } else if (hours <= 9) {
      return 90 + ((9 - hours) * 10).round();
    } else if (hours <= 10) {
      return 80 - ((hours - 9) * 10).round();
    } else {
      return (70 - ((hours - 10) * 10)).clamp(0, 100).round();
    }
  }
  
  /// Check if wake time is tomorrow
  static bool isWakeTomorrow(DateTime wakeTime) {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final wakeDay = DateTime(wakeTime.year, wakeTime.month, wakeTime.day);
    
    return wakeDay.isAtSameMomentAs(tomorrow) || wakeDay.isAfter(tomorrow);
  }
  
  /// Get day label (Today, Tomorrow, or date)
  static String getDayLabel(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final targetDay = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    if (targetDay.isAtSameMomentAs(today)) {
      return 'Today';
    } else if (targetDay.isAtSameMomentAs(tomorrow)) {
      return 'Tomorrow';
    } else {
      return DateFormat('MMM d').format(dateTime);
    }
  }
}
