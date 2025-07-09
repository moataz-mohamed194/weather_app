import '../../../../../core/servers/local_storage_service.dart';
import '../../../../../core/enum/enum_local_data.dart';
import '../../domain/entities/weather_models.dart';

abstract class WeatherLocalDataSource {
  Future<WeatherModel?> getCachedWeatherData();
  Future<void> cacheWeatherData(WeatherModel weatherData);
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final LocalStorageService localStorageService;

  WeatherLocalDataSourceImpl({required this.localStorageService});

  String _getWeatherKey() {
    return LocalDateUsing.weather.text();
  }

  @override
  Future<WeatherModel?> getCachedWeatherData() async {
    final key = _getWeatherKey();
    return localStorageService.getObject<WeatherModel>(
      key,
      (json) => WeatherModel.fromJson(json),
    );
  }

  @override
  Future<void> cacheWeatherData(WeatherModel weatherData) async {
    final key = _getWeatherKey();
    await localStorageService.saveObject<WeatherModel>(
      key,
      weatherData,
      (json) => WeatherModel.fromJson(json),
    );
  }
}
