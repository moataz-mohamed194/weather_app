import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/home/data/data_sources/weather_data_source.dart';
import '../../features/home/data/data_sources/weather_local_data_source.dart';
import '../../features/home/data/repositories/weather_repository_impl.dart';
import '../../features/home/domain/repositories/repositories_weather.dart';
import '../../features/home/presentation/manager/home_provider.dart';
import '../apis_connections/api_connection.dart';
import '../network/network_info.dart';
import '../servers/local_storage_service.dart';

part 'injection_import.dart';
