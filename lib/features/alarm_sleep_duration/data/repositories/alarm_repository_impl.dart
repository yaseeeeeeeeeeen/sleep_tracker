import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/sleep_alarm.dart';
import '../../domain/repositories/alarm_repository.dart';
import '../datasources/alarm_local_datasource.dart';
import '../models/sleep_alarm_model.dart';

/// Implementation of AlarmRepository
class AlarmRepositoryImpl implements AlarmRepository {
  final AlarmLocalDataSource localDataSource;
  // final AlarmRemoteDataSource remoteDataSource; // For future REST API
  // final NetworkInfo networkInfo; // For future REST API

  AlarmRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, SleepAlarm>> saveAlarm(SleepAlarm alarm) async {
    try {
      final model = SleepAlarmModel.fromEntity(alarm);
      final result = await localDataSource.saveAlarm(model);
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
  Future<Either<Failure, SleepAlarm?>> getActiveAlarm() async {
    try {
      final result = await localDataSource.getActiveAlarm();
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
  Future<Either<Failure, List<SleepAlarm>>> getAllAlarms() async {
    try {
      final results = await localDataSource.getAllAlarms();
      return Right(results);
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
  Future<Either<Failure, void>> deleteAlarm(String id) async {
    try {
      await localDataSource.deleteAlarm(id);
      return const Right(null);
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
  Future<Either<Failure, void>> deactivateAllAlarms() async {
    try {
      await localDataSource.deactivateAllAlarms();
      return const Right(null);
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
