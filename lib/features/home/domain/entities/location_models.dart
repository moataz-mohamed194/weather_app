import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_models.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class LocationModel extends Equatable {
  final String? name;
  final String? region;
  final String? country;
  final double? lat;
  final double? lon;
  final String? tzId;
  final int? localtimeEpoch;
  final String? localtime;

  const LocationModel(
      {this.name,
      this.region,
      this.country,
      this.lat,
      this.lon,
      this.tzId,
      this.localtimeEpoch,
      this.localtime});

  /// Creates a LocationModel instance from JSON data
  /// Used when parsing API responses
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return _$LocationModelFromJson(json);
  }

  /// Converts LocationModel to JSON format
  /// Used for local storage and API requests
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  /// Defines equality comparison for Equatable
  /// Used for state comparison in UI updates
  @override
  List<Object?> get props =>
      [name, region, country, lat, lon, tzId, localtimeEpoch, localtime];
}
