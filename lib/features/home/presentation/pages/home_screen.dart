import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/app_color.dart';
import 'package:weather_app/core/vars.dart';
import '../../../../core/enum/state_of_request.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../domain/entities/weather_models.dart';
import '../manager/home_provider.dart';
import '../widgets/build_error_state.dart';
import '../widgets/build_initial_state.dart';
import '../widgets/build_success_state_of_weather.dart';

/// Main home screen that displays weather information
/// Supports both portrait and landscape layouts with responsive design
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  
  // Controller for the city search text field
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        // Create and initialize the home provider with local weather data
        create: (_) => sl<HomeProvider>()..getWeatherLocal(),
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              backgroundColor: AppColor.bgColor,
              body: LayoutBuilder(
                builder: (context, constraints) {
                  // Determine if device is in landscape mode based on screen dimensions
                  final isLandscape =
                      constraints.maxWidth > constraints.maxHeight;

                  // Return appropriate layout based on orientation
                  if (isLandscape) {
                    return _buildLandscapeLayout(
                        context, provider, constraints);
                  } else {
                    return _buildPortraitLayout(context, provider);
                  }
                },
              ),
            );
          },
        ));
  }

  /// Builds the portrait layout with vertical arrangement
  /// Search field at top, weather content below
  Widget _buildPortraitLayout(BuildContext context, HomeProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          // Add top padding for status bar
          MediaQuery.of(context).padding.top.ph,
          
          // City search text field with search button
          CustomTextFieldWidget(
            controller: _controller,
            suffixIcon: CustomButton(
              title: 'Search',
              width: 100,
              textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
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
          20.ph, // Vertical spacing
          
          // Weather content area
          _buildWeatherContent(context, provider),
        ],
      ),
    );
  }

  /// Builds the landscape layout with horizontal arrangement
  /// Search section on left, weather content on right
  Widget _buildLandscapeLayout(
      BuildContext context, HomeProvider provider, BoxConstraints constraints) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: constraints.maxWidth * 0.05,
        vertical: MediaQuery.of(context).padding.top + 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left section: App title and search
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Weather App',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.darkMainColor,
                      ),
                ),
                20.ph,
                
                // Compact search field for landscape mode
                CustomTextFieldWidget(
                  controller: _controller,
                  suffixIcon: CustomButton(
                    title: 'Search',
                    width: 80,
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 8.sp,
                          color: Colors.white,
                        ),
                    fillColor: AppColor.darkMainColor,
                    onTap: () {
                      provider.searchWeatherByCity(city: _controller.text);
                    },
                  ),
                  hint: 'Enter City',
                  width: constraints.maxWidth * 0.4,
                  onFieldSubmitted: (value) {
                    provider.searchWeatherByCity(city: value);
                  },
                ),
              ],
            ),
          ),
          20.pw, // Horizontal spacing
          
          // Right section: Weather content (takes more space)
          Expanded(
            flex: 2,
            child: _buildWeatherContent(context, provider),
          ),
          MediaQuery.of(context).padding.left.pw,
        ],
      ),
    );
  }

  /// Builds the weather content based on the current state
  /// Handles different UI states: initial, loading, success, and error
  Widget _buildWeatherContent(BuildContext context, HomeProvider provider) {
    switch (provider.weatherState) {
      case StateOfRequest.initial:
        return BuildInitialState();
      case StateOfRequest.loading:
        return BuildInitialState();
      case StateOfRequest.done:
        return BuildSuccessStateOfWeather(
            weather: provider.weatherData ?? WeatherModel());
      case StateOfRequest.error:
        return BuildErrorState(
          errorMessage: provider.errorMessage,
        );
    }
  }
}
