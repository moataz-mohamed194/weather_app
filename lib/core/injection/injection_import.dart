part of 'injection_container.dart';

var sl = GetIt.instance;

Future<void> init() async {
  // bloc
  // sl.registerFactory(() =>
  //     BillPaymentProvider(billPaymentRepository: sl(), messagesWidgets: sl()));

  //Repository
  sl.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  //Datasources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(dio: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => MainApiConnection());
}
