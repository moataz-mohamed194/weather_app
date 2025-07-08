import 'package:flutter/material.dart';
import 'package:weather_app/core/vars.dart';

import '../../../../core/app_color.dart';

class BuildInitialState extends StatelessWidget {
  const BuildInitialState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          CircularProgressIndicator(
            color: AppColor.darkMainColor,
          ),
          10.ph,
          Text(
            'Loading weather data...',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
