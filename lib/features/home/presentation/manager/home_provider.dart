import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

import '../../../../core/enum/state_of_request.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/failures_messages.dart';
import '../../domain/entities/weather_models.dart';
import '../../domain/repositories/repositories_weather.dart';

class HomeProvider extends ChangeNotifier {
  final WeatherRepository weatherRepository;

  HomeProvider({required this.weatherRepository});

  StateOfRequest _weatherState = StateOfRequest.initial;
  WeatherModel? _weatherData;
  String? _errorMessage;

  StateOfRequest get weatherState => _weatherState;
  WeatherModel? get weatherData => _weatherData;
  String? get errorMessage => _errorMessage;

  Future<void> searchWeatherByCity({required String? city}) async {
    if (isBlank(city) || _weatherState == StateOfRequest.loading) {
      return;
    }
    _setLoading();

    final result = await weatherRepository.weatherOfCityRepository(
      city: city,
    );

    result.fold(
      (failure) => _handleFailure(failure),
      (weatherData) => _handleSuccess(weatherData),
    );
  }

  void _setLoading() {
    _weatherState = StateOfRequest.loading;
    notifyListeners();
  }

  void _handleSuccess(WeatherModel weatherData) {
    _weatherData = weatherData;
    _weatherState = StateOfRequest.done;
    _errorMessage = null;
    notifyListeners();
  }

  void _handleFailure(Failure failure) {
    _weatherState = StateOfRequest.error;

    if (failure is ServerFailure) {
      _errorMessage = failure.message;
    } else if (failure is CheckYourNetwork) {
      _errorMessage = NO_INTERNET_MESSAGE;
    } else {
      _errorMessage = SERVER_FAILURE_MESSAGE;
    }
    notifyListeners();
  }
}
