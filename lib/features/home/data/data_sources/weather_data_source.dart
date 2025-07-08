import '../../../../../core/apis_connections/api_connection.dart';
import '../../../../../core/connection.dart';
import '../../../../core/enum/keys_of_app.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/weather_models.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getDataOfWeatherRequest({required String? city});
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final MainApiConnection dio;
  WeatherRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<WeatherModel> getDataOfWeatherRequest({required String? city}) async {
    try {
      final response = await dio.get(
          url: '${Connection.baseURL}${dio.dataOfWeatherEndPoint}',
          queryParameters: {'q': city, 'key': KeysOfApp.weatherApiKey.key()});
      if (dio.validResponse(response)) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw response.data['msg'];
      }
    } on MessageException catch (_) {
      rethrow;
    } catch (e) {
      throw MessageException(message: 'An unexpected error occurred');
    }
  }
}
