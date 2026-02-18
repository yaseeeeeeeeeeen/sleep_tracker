/// Sleep duration constants
class SleepConstants {
  // Duration limits (in hours)
  static const int minSleepHours = 1;
  static const int maxSleepHours = 12;
  static const int optimalMinHours = 7;
  static const int optimalMaxHours = 9;
  static const int idealSleepHours = 8;
  
  // Duration in minutes
  static const int minSleepMinutes = 60; // 1 hour
  static const int maxSleepMinutes = 720; // 12 hours
  static const int optimalMinMinutes = 420; // 7 hours
  static const int optimalMaxMinutes = 540; // 9 hours
  
  // Animation durations (in milliseconds)
  static const int dialAnimationDuration = 700;
  static const int cardAnimationDuration = 300;
  static const int buttonAnimationDuration = 200;
  
  // Sleep quality thresholds
  static const int criticalThreshold = 4; // hours
  static const int poorThreshold = 6;
  static const int fairThreshold = 7;
  static const int goodThreshold = 9;
  static const int excessiveThreshold = 10;
}

/// API endpoints (for future REST API integration)
class ApiEndpoints {
  static const String baseUrl = 'https://api.sleeptracker.com'; // Replace with actual URL
  
  // Alarm endpoints
  static const String alarms = '/alarms';
  static const String createAlarm = '/alarms/create';
  static const String updateAlarm = '/alarms/update';
  static const String deleteAlarm = '/alarms/delete';
  
  // Sleep records endpoints
  static const String sleepRecords = '/sleep-records';
  static const String createSleepRecord = '/sleep-records/create';
  static const String getSleepStats = '/sleep-records/stats';
  
  // User profile endpoints
  static const String profile = '/profile';
  static const String updateProfile = '/profile/update';
}

/// Cache keys for SharedPreferences
class CacheKeys {
  static const String userProfile = 'user_profile';
  static const String activeAlarm = 'active_alarm';
  static const String lastSyncTime = 'last_sync_time';
  static const String isDarkMode = 'is_dark_mode';
  static const String notificationsEnabled = 'notifications_enabled';
}

/// Route paths
class Routes {
  static const String home = '/';
  static const String alarmMode = '/alarm-mode';
  static const String alarmDuration = '/alarm/duration';
  static const String alarmFixed = '/alarm/fixed';
  static const String sleepDaily = '/sleep/daily';
  static const String sleepWeekly = '/sleep/weekly';
  static const String sleepMonthly = '/sleep/monthly';
  static const String sleepOverview = '/sleep/overview';
  static const String profile = '/profile';
}
