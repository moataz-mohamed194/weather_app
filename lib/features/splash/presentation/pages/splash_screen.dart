import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/home/presentation/pages/home_screen.dart';
import '../manager/splash_provider.dart';
import 'package:weather_app/core/vars.dart';

import '../../../../core/assets_images.dart';
import '../../../../core/enum/keys_of_app.dart';

/// Splash screen widget displayed on app launch
/// Shows app logo and name, then navigates to the home screen after a delay
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Provide SplashProvider for navigation timing
      create: (_) => SplashProvider(),
      child: Consumer<SplashProvider>(
        builder: (context, provider, child) {
          // When the timer completes, navigate to the home screen
          if (provider.shouldNavigate) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => HomeScreen()),
              );
            });
          }
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App logo
                  Image.asset(AppImages.logo, width: 150.h),
                  30.h.ph, // Vertical spacing
                  // App name
                  Text(KeysOfApp.appName.key(),
                      style: Theme.of(context).textTheme.headlineLarge),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
