import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home_dashboard/presentation/widgets/home_dashboard_screen.dart';
import '../../features/alarm_mode_selection/presentation/widgets/alarm_mode_selection_screen.dart';
import '../../features/alarm_sleep_duration/presentation/widgets/alarm_sleep_duration_screen.dart';
import '../../features/alarm_fixed_time/presentation/widgets/alarm_fixed_time_screen.dart';
import '../../features/sleep_stats_selection/presentation/widgets/sleep_stats_selection_screen.dart';
import '../../features/profile/presentation/widgets/profile_screen.dart';
import '../consts/color_manager.dart';

/// Global key for root navigation
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

/// App router configuration
class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      // Shell route for bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithBottomNav(navigationShell: navigationShell);
        },
        branches: [
          // Home branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomeDashboardScreen(),
              ),
            ],
          ),
          // Stats branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/sleep',
                builder: (context, state) => const SleepStatsSelectionScreen(),
              ),
            ],
          ),
          // Profile branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // Alarm routes (outside bottom nav)
      GoRoute(
        path: '/alarm/mode',
        builder: (context, state) => const AlarmModeSelectionScreen(),
      ),
      GoRoute(
        path: '/alarm/duration',
        builder: (context, state) => const AlarmSleepDurationScreen(),
      ),
      GoRoute(
        path: '/alarm/fixed',
        builder: (context, state) => const AlarmFixedTimeScreen(),
      ),
    ],
  );
}

/// Scaffold with bottom navigation bar
class ScaffoldWithBottomNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithBottomNav({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey.shade600,
          currentIndex: navigationShell.currentIndex,
          onTap: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_rounded),
              label: 'Stats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
