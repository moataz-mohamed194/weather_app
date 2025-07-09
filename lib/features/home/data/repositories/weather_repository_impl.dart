import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/weather_models.dart';
import '../../domain/repositories/repositories_weather.dart';
import '../data_sources/weather_data_source.dart';
import '../data_sources/weather_local_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

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

  @override
  Future<Either<Failure, WeatherModel>> getLocalWeatherData() async {
    try {
      final res = await localDataSource.getCachedWeatherData();
      if (res == null) {
        return Left(CacheFailure());
      }
      return Right(res);
    } on MessageException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveLocalWeatherData(
      {required WeatherModel data}) async {
    await localDataSource.cacheWeatherData(data);
    return Right(true);
  }
}
