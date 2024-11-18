import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/utils/routes.dart';
import 'core/utils/theme.dart';
import 'domain/entities/show.dart';
import 'injection_container.dart';
import 'presentation/screens/details_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/search_screen.dart';
import 'presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DependencyInjection.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'QuadB TV',
        theme: AppTheme.theme,
        routes: {
          AppRoutes.splash: (context) => const SplashScreen(),
          AppRoutes.home: (context) => const HomeScreen(),
          AppRoutes.search: (context) => const SearchScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == AppRoutes.details) {
            final show = settings.arguments as Show;
            return MaterialPageRoute(
              builder: (context) => DetailsScreen(show: show),
            );
          }
          return null;
        },
      ),
    );
  }
}
