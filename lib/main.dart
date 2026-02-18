import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'injection_container.dart';
import 'core/consts/theme_manager.dart';
import 'core/router/app_router.dart';
import 'features/alarm_sleep_duration/presentation/bloc/alarm_bloc.dart';
import 'features/alarm_sleep_duration/presentation/bloc/alarm_event.dart';
import 'features/home_dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/home_dashboard/presentation/bloc/dashboard_event.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // iPhone 12 Pro size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  locator<AlarmBloc>()..add(const LoadAlarmEvent()),
            ),
            BlocProvider(
              create: (context) =>
                  locator<DashboardBloc>()..add(const LoadDashboardEvent()),
            ),
          ],
          child: MaterialApp.router(
            title: 'Sleep Tracker',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.darkTheme,
            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}
