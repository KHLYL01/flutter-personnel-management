import 'package:json_annotation/json_annotation.dart';

part 'jobs_model.g.dart';

@JsonSerializable()
class JobsModel {
  final int? id;
  final String? name;

  JobsModel({this.id, this.name});

  factory JobsModel.fromJson(Map<String, dynamic> json) =>
      _$JobsModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobsModelToJson(this);
}
