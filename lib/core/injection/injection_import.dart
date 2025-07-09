part of 'injection_container.dart';

var sl = GetIt.instance;

Future<void> init() async {
  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // provider
  sl.registerFactory(() => HomeProvider(weatherRepository: sl()));

  //Repository
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  //Datasources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<WeatherLocalDataSource>(
      () => WeatherLocalDataSourceImpl(localStorageService: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => MainApiConnection());
  sl.registerLazySingleton<LocalStorageService>(
    () => LocalStorageServiceImpl(sharedPreferences),
  );
}
