import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'condition_models.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ConditionModel extends Equatable {
  final String? text;
  final String? icon;
  final int? code;

  const ConditionModel({this.text, this.icon, this.code});

  /// Creates a ConditionModel instance from JSON data
  /// Used when parsing API responses
  factory ConditionModel.fromJson(Map<String, dynamic> json) {
    return _$ConditionModelFromJson(json);
  }

  /// Converts ConditionModel to JSON format
  /// Used for local storage and API requests
  Map<String, dynamic> toJson() => _$ConditionModelToJson(this);

  /// Defines equality comparison for Equatable
  /// Used for state comparison in UI updates
  @override
  List<Object?> get props => [text, icon, code];
}
