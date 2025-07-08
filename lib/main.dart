import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/enum/keys_of_app.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/theme_text.dart';
import 'features/splash/presentation/pages/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: KeysOfApp.appName.key(),
            debugShowCheckedModeBanner: false,
            theme: AppTheme().lightTheme,
            home: const SplashScreen(),
          );
        });
  }
}
