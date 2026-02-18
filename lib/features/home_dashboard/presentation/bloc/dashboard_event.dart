import 'package:equatable/equatable.dart';

/// Events for Dashboard BLoC
abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

/// Load dashboard data
class LoadDashboardEvent extends DashboardEvent {
  const LoadDashboardEvent();
}

/// Refresh dashboard data
class RefreshDashboardEvent extends DashboardEvent {
  const RefreshDashboardEvent();
}
