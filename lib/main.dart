import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/enum/keys_of_app.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/theme_text.dart';
import 'features/splash/presentation/pages/splash_screen.dart';

/// Main entry point of the weather application
/// This function initializes the app and sets up dependencies
Future<void> main() async {
  // Ensure Flutter bindings are initialized before any platform channels are used
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  // Initialize dependency injection container
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        // Design size for responsive scaling (width: 360, height: 690)
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (_, child) {
          return MaterialApp(
            title: KeysOfApp.appName.key(),
            debugShowCheckedModeBanner: false,
            // Apply custom light theme
            theme: AppTheme().lightTheme,
            // Set splash screen as the initial route
            home: const SplashScreen(),
          );
        });
  }
}
