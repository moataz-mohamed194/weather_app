import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

extension DioErrorExtensions on DioException {
  bool get is401 => response?.statusCode == 401;

  bool get is406 => response?.statusCode == 406;

  bool get is40X =>
      (response?.statusCode ?? 0) >= 400 && (response?.statusCode ?? 0) < 500;

  bool get is500 => response?.statusCode == 500;

  String get readableError {
    // No Response ? then No Server...
    if (response?.data == null) {
      return ('cannot reach');
    }

    if (is500) {
      return ('internal server error');
    }

    // if response is String .. ex: 404
    if (response!.data.runtimeType == String) {
      // Url Not Found...
      if (response!.statusCode == 404) {
        return ('404 error');
      }
      return '${response!.data}';
      // Else if Server Returned something..
    } else if (response!.data is Map<String, dynamic>) {
      if (response!.data['errors'] != null &&
          response!.data['errors'] is Map<String, dynamic>) {
        return '${response!.data['errors'].values.first.first}';
      }
      if (response!.data.values.first is List) {
        return '${response!.data.values.first.first}';
      }
      return '${response!.data.values.first}';
    }

    // IDK what the hell is this. so something weird happened;
    return ('server error');
  }
}

extension DynamicSizeFont on OffsetBase{

  double reDeginSize(int size, BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;

    double baseSize = 16.0; // Base font size
    double scaleFactor = screenWidth / 375.0; // 375 is a standard width

    // You can adjust these values according to your design requirements
    if (screenWidth < 600) {
      return baseSize * scaleFactor; // Small devices
    } else if (screenWidth < 900) {
      return baseSize * scaleFactor * 1.2; // Medium-sized devices
    } else {
      return baseSize * scaleFactor * 1.5; // Large devices
    }
  }
}