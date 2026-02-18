import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/sleep_summary.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_local_datasource.dart';

/// Implementation of DashboardRepository
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardLocalDataSource localDataSource;

  DashboardRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, SleepSummary>> getSleepSummary() async {
    try {
      final result = await localDataSource.getSleepSummary();
      return Right(result);
    } on CacheException catch (e) {
      return Left(DatabaseFailure.fromException(e));
    } catch (e) {
      return Left(DatabaseFailure(
        message: 'Unexpected error: ${e.toString()}',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> hasActiveAlarm() async {
    try {
      final result = await localDataSource.hasActiveAlarm();
      return Right(result);
    } on CacheException catch (e) {
      return Left(DatabaseFailure.fromException(e));
    } catch (e) {
      return Left(DatabaseFailure(
        message: 'Unexpected error: ${e.toString()}',
        statusCode: 500,
      ));
    }
  }
}
