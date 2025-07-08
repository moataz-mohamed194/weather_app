import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/enum/state_of_request.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/weather_models.dart';
import '../../domain/repositories/repositories_weather.dart';

class HomeProvider extends ChangeNotifier {
  final WeatherRepository weatherRepository;

  HomeProvider({required this.weatherRepository});

  // State variables
  StateOfRequest _weatherState = StateOfRequest.initial;
  WeatherModel? _weatherData;
  String? _errorMessage;

  // Getters
  StateOfRequest get weatherState => _weatherState;
  WeatherModel? get weatherData => _weatherData;
  String? get errorMessage => _errorMessage;

  Future<void> searchWeatherByCity({required String? city}) async {
    _setLoading();

    final result = await weatherRepository.weatherOfCityRepository(
      city: city,
    );

    result.fold(
      (failure) => _handleFailure(failure),
      (weatherData) => _handleSuccess(weatherData),
    );
  }

  // Set loading state
  void _setLoading() {
    _weatherState = StateOfRequest.loading;
    notifyListeners();
  }

  // Handle success
  void _handleSuccess(WeatherModel weatherData) {
    _weatherData = weatherData;
    _weatherState = StateOfRequest.done;
    _errorMessage = null;
    notifyListeners();
  }

  // Handle failure
  void _handleFailure(Failure failure) {
    _weatherState = StateOfRequest.error;

    if (failure is ServerFailure) {
      _errorMessage = failure.message;
    } else if (failure is CheckYourNetwork) {
      _errorMessage = 'No internet connection. Please check your network.';
    } else {
      _errorMessage = 'Something went wrong. Please try again.';
    }

    notifyListeners();
  }
}
