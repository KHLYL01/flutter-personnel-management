import 'package:json_annotation/json_annotation.dart';

part 'emp_entedab_det_model.g.dart';

@JsonSerializable()
class EmpEntedabDetModel {
  final int? maxId;
  final int? entedabId;
  final int? empId;

  final String? empName;
  final double? salary;
  final String? fia;
  final double? draga;
  final double? naqlBadal;
  final double? entedabBadal;

  final int? prev;
  final double? externalEntedab;

  EmpEntedabDetModel({
    this.maxId,
    this.entedabId,
    this.empId,
    this.empName,
    this.salary,
    this.fia,
    this.draga,
    this.naqlBadal,
    this.entedabBadal,
    this.prev,
    this.externalEntedab,
  });

  factory EmpEntedabDetModel.fromJson(Map<String, dynamic> json) =>
      _$EmpEntedabDetModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpEntedabDetModelToJson(this);
}
