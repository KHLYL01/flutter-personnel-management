import 'package:json_annotation/json_annotation.dart';

part 'nations_model.g.dart';

@JsonSerializable()
class NationsModel {
  final int? id;
  final String? name;

  NationsModel({this.id, this.name});

  factory NationsModel.fromJson(Map<String, dynamic> json) =>
      _$NationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NationsModelToJson(this);

  List<dynamic> get toList => [id, name];
}
