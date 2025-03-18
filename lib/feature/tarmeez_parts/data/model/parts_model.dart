import 'package:json_annotation/json_annotation.dart';

part 'parts_model.g.dart';

@JsonSerializable()
class PartsModel {
  final int? id;
  final String? name;

  PartsModel({this.id, this.name});

  factory PartsModel.fromJson(Map<String, dynamic> json) =>
      _$PartsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartsModelToJson(this);
}
