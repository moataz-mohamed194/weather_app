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

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return _$WeatherModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  @override
  List<Object?> get props => [location, current];
}
