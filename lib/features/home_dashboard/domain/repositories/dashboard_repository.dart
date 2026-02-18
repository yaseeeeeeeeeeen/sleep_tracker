import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/sleep_summary.dart';

/// Repository interface for home dashboard operations
abstract class DashboardRepository {
  /// Get sleep summary statistics
  Future<Either<Failure, SleepSummary>> getSleepSummary();

  /// Check if there's an active alarm
  Future<Either<Failure, bool>> hasActiveAlarm();
}
