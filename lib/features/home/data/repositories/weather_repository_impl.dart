import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/weather_models.dart';
import '../../domain/repositories/repositories_weather.dart';
import '../data_sources/weather_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  WeatherRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, WeatherModel>> weatherOfCityRepository(
      {required String? city}) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.getDataOfWeatherRequest(city: city);
        return Right(res);
      } on MessageException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(CacheFailure());
      }
    } else {
      return Left(CheckYourNetwork());
    }
  }
}
