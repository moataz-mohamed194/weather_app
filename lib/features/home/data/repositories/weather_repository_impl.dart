import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/weather_models.dart';
import '../../domain/repositories/repositories_weather.dart';
import '../data_sources/weather_data_source.dart';
import '../data_sources/weather_local_data_source.dart';

/// Implementation of the weather repository
/// Handles data flow between remote API, local storage, and domain layer
/// Uses Either pattern for functional error handling
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  /// Fetches weather data for a specific city
  /// Checks network connectivity and handles both remote and local data sources
  @override
  Future<Either<Failure, WeatherModel>> weatherOfCityRepository(
      {required String? city}) async {
    // Check if device has internet connection
    if (await networkInfo.isConnected) {
      try {
        // Fetch data from remote API
        final res = await remoteDataSource.getDataOfWeatherRequest(city: city);
        return Right(res);
      } on MessageException catch (e) {
        // Handle server-specific errors
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        // Handle unexpected errors
        return Left(CacheFailure());
      }
    } else {
      // Return network error if no internet connection
      return Left(CheckYourNetwork());
    }
  }

  /// Retrieves cached weather data from local storage
  /// Used for offline access and initial app load
  @override
  Future<Either<Failure, WeatherModel>> getLocalWeatherData() async {
    try {
      final res = await localDataSource.getCachedWeatherData();
      if (res == null) {
        // Return cache failure if no data is available
        return Left(CacheFailure());
      }
      return Right(res);
    } on MessageException catch (e) {
      // Handle local storage errors
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      // Handle unexpected local storage errors
      return Left(CacheFailure());
    }
  }

  /// Saves weather data to local storage for offline access
  /// Always returns success as local storage operations are typically reliable
  @override
  Future<Either<Failure, bool>> saveLocalWeatherData(
      {required WeatherModel data}) async {
    await localDataSource.cacheWeatherData(data);
    return Right(true);
  }
}
