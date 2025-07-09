import '../../../../../core/apis_connections/api_connection.dart';
import '../../../../../core/connection.dart';
import '../../../../core/enum/keys_of_app.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/weather_models.dart';
import 'package:dartz/dartz.dart';

/// Abstract class defining the contract for remote weather data operations
/// Part of the repository pattern for data layer abstraction
abstract class WeatherRemoteDataSource {
  /// Fetches weather data for a specific city from the remote API
  Future<WeatherModel> getDataOfWeatherRequest({required String? city});
}

/// Implementation of the remote weather data source
/// Handles API calls to external weather service and data parsing
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final MainApiConnection dio;
  
  WeatherRemoteDataSourceImpl({
    required this.dio,
  });

  /// Fetches weather data from the remote API
  /// Constructs the API URL with city parameter and API key
  @override
  Future<WeatherModel> getDataOfWeatherRequest({required String? city}) async {
    // Make API request with city and API key parameters
    final response = await dio.get(
        url: '${Connection.baseURL}${dio.dataOfWeatherEndPoint}',
        queryParameters: {'q': city, 'key': KeysOfApp.weatherApiKey.key()});
    
    // Handle the response using Either pattern
    return response.fold(
      (left) => throw left, // Re-throw exceptions for repository to handle
      (right) => WeatherModel.fromJson(right.data), // Parse JSON to model
    );
  }
}
