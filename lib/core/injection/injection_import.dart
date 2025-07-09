part of 'injection_container.dart';

// Global instance of GetIt for dependency injection
var sl = GetIt.instance;

/// Initializes the dependency injection container
/// Registers all services, repositories, and data sources
Future<void> init() async {
  // Initialize SharedPreferences for local data storage
  final sharedPreferences = await SharedPreferences.getInstance();

  // Register UI providers (using factory for new instances each time)
  sl.registerFactory(() => HomeProvider(weatherRepository: sl()));

  // Register repositories (using lazy singleton for shared instances)
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  // Register data sources (using lazy singleton for shared instances)
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<WeatherLocalDataSource>(
      () => WeatherLocalDataSourceImpl(localStorageService: sl()));

  // Register core services and utilities
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => MainApiConnection());
  sl.registerLazySingleton<LocalStorageService>(
    () => LocalStorageServiceImpl(sharedPreferences),
  );
}
