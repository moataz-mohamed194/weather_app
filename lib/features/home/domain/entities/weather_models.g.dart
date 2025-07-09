// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      current: json['current'] == null
          ? null
          : CurrentModel.fromJson(json['current'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'location': instance.location?.toJson(),
      'current': instance.current?.toJson(),
    };
