import 'package:json_annotation/json_annotation.dart';

part 'emp_hasmiat_det_model.g.dart';

@JsonSerializable()
class EmpHasmiatDetModel {
  final int? id;
  final String? employeeName;
  final double? salary;
  final double? naqlBadal;
  final double? ghyab;
  final double? tagmee3;
  final String? min;
  final double? gza;
  final String? notes;

  final int? maxId;
  final int? hasmId;
  final int? empId;
  final String? details;
  final int? mosta7qTotal;

  EmpHasmiatDetModel({
    this.maxId,
    this.hasmId,
    this.empId,
    this.details,
    this.mosta7qTotal,
    this.id,
    this.employeeName,
    this.salary,
    this.naqlBadal,
    this.ghyab,
    this.tagmee3,
    this.min,
    this.gza,
    this.notes,
  });

  factory EmpHasmiatDetModel.fromJson(Map<String, dynamic> json) =>
      _$EmpHasmiatDetModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpHasmiatDetModelToJson(this);
}
