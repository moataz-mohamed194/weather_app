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
