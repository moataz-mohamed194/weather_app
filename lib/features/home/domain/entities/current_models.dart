import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'condition_models.dart';

part 'current_models.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CurrentModel extends Equatable {
  final int? lastUpdatedEpoch;
  final String? lastUpdated;
  final double? tempC;
  final double? tempF;
  final int? isDay;
  final ConditionModel? condition;
  final double? windMph;
  final double? windKph;
  final int? windDegree;
  final String? windDir;
  final int? pressureMb;
  final double? pressureIn;
  final int? precipMm;
  final int? precipIn;
  final int? humidity;
  final int? cloud;
  final int? feelslikeC;
  final double? feelslikeF;
  final double? windchillC;
  final double? windchillF;
  final double? heatindexC;
  final double? heatindexF;
  final double? dewpointC;
  final double? dewpointF;
  final int? visKm;
  final int? visMiles;
  final int? uv;
  final double? gustMph;
  final double? gustKph;

  const CurrentModel(
      {this.lastUpdatedEpoch,
      this.lastUpdated,
      this.tempC,
      this.tempF,
      this.isDay,
      this.condition,
      this.windMph,
      this.windKph,
      this.windDegree,
      this.windDir,
      this.pressureMb,
      this.pressureIn,
      this.precipMm,
      this.precipIn,
      this.humidity,
      this.cloud,
      this.feelslikeC,
      this.feelslikeF,
      this.windchillC,
      this.windchillF,
      this.heatindexC,
      this.heatindexF,
      this.dewpointC,
      this.dewpointF,
      this.visKm,
      this.visMiles,
      this.uv,
      this.gustMph,
      this.gustKph});

  /// Creates a CurrentModel instance from JSON data
  /// Used when parsing API responses
  factory CurrentModel.fromJson(Map<String, dynamic> json) {
    return _$CurrentModelFromJson(json);
  }

  /// Converts CurrentModel to JSON format
  /// Used for local storage and API requests
  Map<String, dynamic> toJson() => _$CurrentModelToJson(this);

  /// Defines equality comparison for Equatable
  /// Used for state comparison in UI updates
  @override
  List<Object?> get props => [
        lastUpdatedEpoch,
        lastUpdated,
        tempC,
        tempF,
        isDay,
        condition,
        windMph,
        windKph,
        windDegree,
        windDir,
        pressureMb,
        pressureIn,
        precipMm,
        precipIn,
        humidity,
        cloud,
        feelslikeC,
        feelslikeF,
        windchillC,
        windchillF,
        heatindexC,
        heatindexF,
        dewpointC,
        dewpointF,
        visKm,
        visMiles,
        uv,
        gustMph,
        gustKph
      ];
}
