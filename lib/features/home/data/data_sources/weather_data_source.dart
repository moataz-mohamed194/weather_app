import '../../../../../core/apis_connections/api_connection.dart';
import '../../../../../core/connection.dart';
import '../../../../core/enum/keys_of_app.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/weather_models.dart';
import 'package:dartz/dartz.dart';

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
    final response = await dio.get(
        url: '${Connection.baseURL}${dio.dataOfWeatherEndPoint}',
        queryParameters: {'q': city, 'key': KeysOfApp.weatherApiKey.key()});
    return response.fold(
      (left) => throw left,
      (right) => WeatherModel.fromJson(right.data),
    );
  }
}
