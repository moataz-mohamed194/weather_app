import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageService {
  Future<void> saveObject<T>(
      String key, T value, T Function(Map<String, dynamic>) fromJson);

  T? getObject<T>(String key, T Function(Map<String, dynamic>) fromJson);
}

class LocalStorageServiceImpl implements LocalStorageService {
  final SharedPreferences prefs;

  LocalStorageServiceImpl(this.prefs);

  Future<void> _saveJson(String key, Map<String, dynamic> value) async {
    final jsonString = jsonEncode(value);
    await prefs.setString(key, jsonString);
  }

  Map<String, dynamic>? _getJson(String key) {
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      try {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> saveObject<T>(
      String key, T value, T Function(Map<String, dynamic>) fromJson) async {
    if (value == null) return;

    try {
      final Map<String, dynamic> jsonMap = (value as dynamic).toJson();
      await _saveJson(key, jsonMap);
    } catch (e) {
      throw Exception('Failed to save object: $e');
    }
  }

  @override
  T? getObject<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    final jsonMap = _getJson(key);
    if (jsonMap != null) {
      try {
        return fromJson(jsonMap);
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
