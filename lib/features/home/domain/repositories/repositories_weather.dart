import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/weather_models.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherModel>> weatherOfCityRepository({
    required String? city,
  });
  Future<Either<Failure, WeatherModel>> getLocalWeatherData();
  Future<Either<Failure, bool>> saveLocalWeatherData(
      {required WeatherModel data});
}
