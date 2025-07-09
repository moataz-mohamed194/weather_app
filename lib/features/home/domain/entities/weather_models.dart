import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'current_models.dart';
import 'location_models.dart';

part 'weather_models.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class WeatherModel extends Equatable {
  final LocationModel? location;
  final CurrentModel? current;

  const WeatherModel({this.location, this.current});

  /// Creates a WeatherModel instance from JSON data
  /// Used when parsing API responses
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return _$WeatherModelFromJson(json);
  }

  /// Converts WeatherModel to JSON format
  /// Used for local storage and API requests
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  /// Defines equality comparison for Equatable
  /// Used for state comparison in UI updates
  @override
  List<Object?> get props => [location, current];
}
