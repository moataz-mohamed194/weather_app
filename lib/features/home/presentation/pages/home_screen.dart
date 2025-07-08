import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/app_color.dart';
import 'package:weather_app/core/vars.dart';

import '../../../../core/assets_images.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../manager/home_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => sl<HomeProvider>(),
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              backgroundColor: AppColor.bgColor,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    MediaQuery.of(context).padding.top.ph,
                    CustomTextFieldWidget(
                      controller: _controller,
                      suffixIcon: CustomButton(
                        title: 'Search',
                        width: 100,
                        textStyle:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.sp,
                                ),
                        fillColor: AppColor.darkMainColor,
                        onTap: () {
                          provider.searchWeatherByCity(city: _controller.text);
                        },
                      ),
                      hint: 'Enter City',
                      width: MediaQuery.of(context).size.width,
                      onFieldSubmitted: (value) {
                        provider.searchWeatherByCity(city: value);
                      },
                    ),
                    20.ph,
                    _buildWeatherContent(context, provider),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget _buildWeatherContent(BuildContext context, HomeProvider provider) {
    switch (provider.weatherState) {
      case WeatherState.initial:
        return _buildInitialState(context);
      case WeatherState.loading:
        return _buildLoadingState(context);
      case WeatherState.success:
        return _buildSuccessState(context, provider);
      case WeatherState.error:
        return _buildErrorState(context, provider);
    }
  }

  Widget _buildInitialState(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Icon(
            Icons.search,
            size: 50,
            color: Colors.grey[400],
          ),
          10.ph,
          Text(
            'Search for a city to get weather information',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
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

  Widget _buildSuccessState(BuildContext context, HomeProvider provider) {
    final weather = provider.weatherData;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            weather?.location?.name ?? 'Unknown City',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          10.ph,
          Text(
            '${weather?.current?.tempC?.round()}°C',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColor.darkMainColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          10.ph,
          CachedNetworkImage(
            imageUrl: (weather?.current?.condition?.icon ?? '').image,
            placeholder: (context, url) => const Center(
              child: CupertinoActivityIndicator(),
            ),
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 50.h,
                // width: 50.h,
                decoration: BoxDecoration(
                  image: DecorationImage(image: imageProvider),
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
            weather?.current?.condition?.text ?? 'Unknown',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          20.ph,
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, HomeProvider provider) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 50,
            color: Colors.red[400],
          ),
          10.ph,
          Text(
            provider.errorMessage ?? 'An error occurred',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
