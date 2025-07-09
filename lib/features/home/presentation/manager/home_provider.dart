import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

import '../../../../core/enum/state_of_request.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/failures_messages.dart';
import '../../domain/entities/weather_models.dart';
import '../../domain/repositories/repositories_weather.dart';

/// State management class for the home screen
/// Handles weather data fetching, caching, and UI state management
class HomeProvider extends ChangeNotifier {
  final WeatherRepository weatherRepository;

  HomeProvider({required this.weatherRepository});

  // Private state variables
  StateOfRequest _weatherState = StateOfRequest.initial;
  WeatherModel? _weatherData;
  String? _errorMessage;

  // Public getters for accessing state
  StateOfRequest get weatherState => _weatherState;
  WeatherModel? get weatherData => _weatherData;
  String? get errorMessage => _errorMessage;

  /// Searches for weather data by city name
  /// Validates input and handles API calls with proper error handling
  Future<void> searchWeatherByCity({required String? city}) async {
    // Prevent multiple simultaneous requests and empty city searches
    if (isBlank(city) || _weatherState == StateOfRequest.loading) {
      return;
    }
    
    // Set loading state
    _setLoading();

    // Call repository to fetch weather data
    final result = await weatherRepository.weatherOfCityRepository(
      city: city,
    );

    // Handle the result using Either pattern for error handling
    result.fold(
      (failure) => _handleFailure(failure),
      (weatherData) => _handleSuccess(weatherData),
    );
  }

  /// Sets the loading state and notifies listeners
  void _setLoading() {
    _weatherState = StateOfRequest.loading;
    notifyListeners();
  }

  /// Handles successful weather data retrieval
  /// Updates state and stores data locally for offline access
  void _handleSuccess(WeatherModel weatherData) {
    _weatherData = weatherData;
    _weatherState = StateOfRequest.done;
    _errorMessage = null;
    
    // Store weather data locally for offline access
    _storeWeatherDataLocally(weatherData);
    
    // Notify UI to rebuild
    notifyListeners();
  }

  /// Stores weather data in local storage for offline access
  void _storeWeatherDataLocally(WeatherModel? data) async {
    if (data != null) {
      await weatherRepository.saveLocalWeatherData(data: data);
    }
  }

  /// Retrieves cached weather data from local storage
  /// Used for offline access and initial app load
  Future<void> getWeatherLocal() async {
    final result = await weatherRepository.getLocalWeatherData();

    result.fold(
      (failure) {},
      (weatherData) => _handleSuccess(weatherData),
    );
  }

  /// Handles different types of failures and sets appropriate error messages
  /// Maps failure types to user-friendly error messages
  void _handleFailure(Failure failure) {
    _weatherState = StateOfRequest.error;

    if (failure is ServerFailure) {
      // Use server-provided error message
      _errorMessage = failure.message;
    } else if (failure is CheckYourNetwork) {
      // Network connectivity error
      _errorMessage = NO_INTERNET_MESSAGE;
    } else {
      // Generic server error
      _errorMessage = SERVER_FAILURE_MESSAGE;
    }
    
    // Notify UI to rebuild with error state
    notifyListeners();
  }
}
