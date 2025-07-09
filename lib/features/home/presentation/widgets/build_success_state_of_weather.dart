import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/vars.dart';

import '../../../../core/app_color.dart';
import '../../domain/entities/weather_models.dart';

class BuildSuccessStateOfWeather extends StatelessWidget {
  final WeatherModel weather;

  const BuildSuccessStateOfWeather({super.key, required this.weather});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: (weather.current?.condition?.icon ?? '').image,
            placeholder: (context, url) => const Center(
              child: CupertinoActivityIndicator(),
            ),
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 50.h,
                width: 50.h,
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.fill),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return Icon(
                Icons.error_outline,
                color: Colors.red,
              );
            },
          ),
          10.ph,
          Text(
            weather.location?.name ?? 'Unknown City',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          10.ph,
          Text(
            '${weather.current?.tempC?.round()}°C',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColor.darkMainColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          10.ph,
          Text(
            weather.current?.condition?.text ?? 'Unknown',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          20.ph,
        ],
      ),
    );
  }
}
