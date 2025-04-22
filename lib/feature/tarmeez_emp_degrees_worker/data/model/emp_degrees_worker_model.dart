import 'package:json_annotation/json_annotation.dart';

part 'emp_degrees_worker_model.g.dart';

@JsonSerializable()
class EmpDegreesWorkerModel {
  final int? id;
  final String? fia;
  final double? draga;
  final double? salary;
  final double? naqlBadal;
  final double? elawa;

  EmpDegreesWorkerModel({
    this.id,
    this.fia,
    this.draga,
    this.salary,
    this.naqlBadal,
    this.elawa,
  });

  factory EmpDegreesWorkerModel.fromJson(Map<String, dynamic> json) =>
      _$EmpDegreesWorkerModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpDegreesWorkerModelToJson(this);
}
