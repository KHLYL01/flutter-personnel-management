import 'package:json_annotation/json_annotation.dart';

part 'emp_takleef_det_model.g.dart';

@JsonSerializable()
class EmpTakleefDetModel {
  final int? maxId;
  final int? takleefId;
  final int? empId;
  final String? empWork;
  final double? period;
  final String? datBegin;
  final String? datEnd;

  final String? empName;
  final double? salary;
  final double? naqlBadal;

  EmpTakleefDetModel({
    this.maxId,
    this.takleefId,
    this.empId,
    this.empWork,
    this.period,
    this.datBegin,
    this.datEnd,
    this.empName,
    this.salary,
    this.naqlBadal,
  });

  factory EmpTakleefDetModel.fromJson(Map<String, dynamic> json) =>
      _$EmpTakleefDetModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpTakleefDetModelToJson(this);
}
