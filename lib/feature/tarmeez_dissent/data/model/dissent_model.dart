import 'package:json_annotation/json_annotation.dart';

part 'dissent_model.g.dart';

@JsonSerializable()
class DissentModel {
  final int? id;
  final String? name;

  DissentModel({this.id, this.name});

  factory DissentModel.fromJson(Map<String, dynamic> json) =>
      _$DissentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DissentModelToJson(this);
}
