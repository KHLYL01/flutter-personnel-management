import 'package:json_annotation/json_annotation.dart';

part 'emp_mokhalfat_det_model.g.dart';

@JsonSerializable()
class EmpMokhalfatDetModel {
  final int? id;
  final String? empName;
  final double? salary;
  final double? naqlBadal;
  final String? fia;
  final double? draga;

  final int? maxId;
  final int? empId;
  final int? mokhalfaId;
  final double? gza;

  EmpMokhalfatDetModel({
    this.id,
    this.empName,
    this.salary,
    this.naqlBadal,
    this.fia,
    this.draga,
    this.maxId,
    this.empId,
    this.mokhalfaId,
    this.gza,
  });

  factory EmpMokhalfatDetModel.fromJson(Map<String, dynamic> json) =>
      _$EmpMokhalfatDetModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpMokhalfatDetModelToJson(this);
}
