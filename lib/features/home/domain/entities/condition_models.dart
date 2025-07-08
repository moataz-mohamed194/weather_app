import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'condition_models.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ConditionModel extends Equatable {
  final String? text;
  final String? icon;
  final int? code;

  const ConditionModel({this.text, this.icon, this.code});

  factory ConditionModel.fromJson(Map<String, dynamic> json) {
    return _$ConditionModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConditionModelToJson(this);

  @override
  List<Object?> get props => [text, icon, code];
}
