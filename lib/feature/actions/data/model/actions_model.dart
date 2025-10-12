import 'package:json_annotation/json_annotation.dart';

part 'actions_model.g.dart';

@JsonSerializable()
class ActionsModel {
  final int? id;
  final String? username;
  final String? action;
  final String? dat;
  final String? tim;

  ActionsModel({
    this.id,
    this.username,
    this.dat,
    this.action,
    this.tim,
  });

  factory ActionsModel.fromJson(Map<String, dynamic> json) =>
      _$ActionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActionsModelToJson(this);
}
