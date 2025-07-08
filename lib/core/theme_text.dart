import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      textTheme: TextTheme(
        headlineLarge: TextStyle(
            color: Colors.black, fontSize: 25.sp, fontWeight: FontWeight.w700),
      ));
}
