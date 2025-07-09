import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as di;
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../error/exceptions.dart';
import '../error/failures_messages.dart';

/// Main API connection class for handling HTTP requests
/// Manages Dio HTTP client, interceptors, and request/response handling
class MainApiConnection {
  // Singleton pattern implementation
  MainApiConnection() {
    // Attach logging interceptor only in debug mode for performance
    if (kDebugMode) dio.interceptors.add(_logger);
  }

  // HTTP client instance using Dio
  Dio dio = Dio();

  // Logger interceptor for debugging API requests and responses
  final PrettyDioLogger _logger = PrettyDioLogger(
    requestBody: true,
    responseBody: true,
    requestHeader: true,
    error: true,
  );

  // Default headers for API requests
  static const Map<String, dynamic> apiHeaders = <String, dynamic>{
    'Accept': 'application/json'
  };

  ////////////////////////////// END POINTS ///////////////////////////////////
  /// Weather API endpoint for current weather data
  String dataOfWeatherEndPoint = "current.json";

////////////////////////////////////////////////////////////////////////////

  /// Validates HTTP response status codes
  /// Returns true for successful responses (200-299 range)
  bool validResponse(di.Response response) {
    int? statusCode = response.statusCode;
    if (statusCode == null) {
      return false;
    } else {
      return (statusCode >= 200 && statusCode < 300);
    }
  }

  /// Performs HTTP GET requests with error handling
  /// Returns Either<ServerException, Response> for functional error handling
  Future<Either<ServerException, Response>> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      // Perform GET request with query parameters
      di.Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: dioOptions(),
      );

      // Validate response status
      if (validResponse(response)) {
        return Right(response);
      } else {
        // Handle server error responses
        throw MessageException(
            message:
                response.data['error']['message'] ?? SERVER_FAILURE_MESSAGE);
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors (network, timeout, etc.)
      if (e.response?.data != null &&
          e.response?.data['error']['message'] != null) {
        throw MessageException(message: e.response?.data['error']['message']);
      }
      throw MessageException(message: e.message ?? SERVER_FAILURE_MESSAGE);
    }
  }

  /// Creates Dio options with custom headers
  /// Allows overriding default headers when needed
  Options dioOptions([Map<String, String?>? headers]) {
    return Options(
      // contentType: 'application/json',
      headers: {
        ...headers ?? apiHeaders,
      },
    );
  }
}
