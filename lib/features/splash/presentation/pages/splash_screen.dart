import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/home/presentation/pages/home_screen.dart';
import '../manager/splash_provider.dart';
import 'package:weather_app/core/vars.dart';

import '../../../../core/assets_images.dart';
import '../../../../core/enum/keys_of_app.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashProvider(),
      child: Consumer<SplashProvider>(
        builder: (context, provider, child) {
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
                  Image.asset(AppImages.logo, width: 150.h),
                  30.h.ph,
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
