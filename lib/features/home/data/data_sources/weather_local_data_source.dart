import '../../../../../core/servers/local_storage_service.dart';
import '../../../../../core/enum/enum_local_data.dart';
import '../../domain/entities/weather_models.dart';

/// Abstract class defining the contract for local weather data operations
/// Part of the repository pattern for data layer abstraction
abstract class WeatherLocalDataSource {
  /// Retrieves cached weather data from local storage
  Future<WeatherModel?> getCachedWeatherData();
  
  /// Saves weather data to local storage for offline access
  Future<void> cacheWeatherData(WeatherModel weatherData);
}

/// Implementation of the local weather data source
/// Handles local storage operations using SharedPreferences
class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final LocalStorageService localStorageService;

  WeatherLocalDataSourceImpl({required this.localStorageService});

  /// Generates the storage key for weather data
  /// Uses enum to maintain consistent key naming
  String _getWeatherKey() {
    return LocalDateUsing.weather.text();
  }

  /// Retrieves cached weather data from local storage
  /// Returns null if no data is found or if data is corrupted
  @override
  Future<WeatherModel?> getCachedWeatherData() async {
    final key = _getWeatherKey();
    return localStorageService.getObject<WeatherModel>(
      key,
      (json) => WeatherModel.fromJson(json), // JSON to model conversion
    );
  }

  /// Saves weather data to local storage for offline access
  /// Uses JSON serialization for storage
  @override
  Future<void> cacheWeatherData(WeatherModel weatherData) async {
    final key = _getWeatherKey();
    await localStorageService.saveObject<WeatherModel>(
      key,
      weatherData,
      (json) => WeatherModel.fromJson(json), // Model to JSON conversion
    );
  }
}
