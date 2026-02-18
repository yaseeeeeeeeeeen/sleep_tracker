import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/sleep_summary.dart';
import '../repositories/dashboard_repository.dart';

/// Use case for getting sleep summary statistics
class GetSleepSummary implements UseCase<SleepSummary, NoParams> {
  final DashboardRepository repository;

  GetSleepSummary(this.repository);

  @override
  Future<Either<Failure, SleepSummary>> call(NoParams params) async {
    return await repository.getSleepSummary();
  }
}
