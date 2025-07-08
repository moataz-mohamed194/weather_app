import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as di;
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../error/exceptions.dart';

class MainApiConnection {
  //Singleton
  MainApiConnection() {
    // Attach Interceptors.
    if (kDebugMode) dio.interceptors.add(_logger);
  }

  // static final ApiProvider instance = ApiProvider._();

  // Http Client
  Dio dio = Dio();

  // Logger
  final PrettyDioLogger _logger = PrettyDioLogger(
    requestBody: true,
    responseBody: true,
    requestHeader: true,
    error: true,
  );

  // Performance Interceptor

  // Headers
  static const Map<String, dynamic> apiHeaders = <String, dynamic>{
    'Accept': 'application/json'
  };

  ////////////////////////////// END POINTS ///////////////////////////////////
  String dataOfWeatherEndPoint = "current.json";

////////////////////////////////////////////////////////////////////////////

  // Validating Request.
  bool validResponse(di.Response response) {
    int? statusCode = response.statusCode;
    bool? result = response.data['result'];
    if (statusCode == null || result == false) {
      return false;
    } else {
      return (statusCode >= 200 && statusCode < 300);
    }
  }
////////////////////////////////////////////////////////////////////////////

  ///////////////////////////////// UTILS /////////////////////////////////////

  Future<di.Response<dynamic>> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      di.Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: dioOptions(),
      );

      if (validResponse(response)) {
        return response;
      } else {
        throw MessageException(
            message: response.data['msg'] ??
                'An error occurred while processing your request.');
      }
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data['msg'] != null) {
        throw MessageException(message: e.response?.data['msg']);
      }
      throw MessageException(
          message:
              e.message ?? 'An error occurred while processing your request.');
    }
  }

  Future<di.Response<dynamic>> post({
    required String url,
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, String?>? headers,
  }) async {
    try {
      final response = await dio.post(
        url,
        queryParameters: queryParameters,
        data: data,
        options: dioOptions(),
      );
      if (validResponse(response)) {
        return response;
      } else {
        throw MessageException(
            message: response.data['msg'] ??
                'An error occurred while processing your request.');
      }
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data['msg'] != null) {
        throw MessageException(message: e.response?.data['msg']);
      }
      throw MessageException(
          message:
              e.message ?? 'An error occurred while processing your request.');
    }
  }

  Options dioOptions([Map<String, String?>? headers]) {
    return Options(
      // contentType: 'application/json',
      headers: {
        ...headers ?? apiHeaders,
      },
    );
  }
}
