import 'package:json_annotation/json_annotation.dart';

part 'emp_dowra_det_model.g.dart';

@JsonSerializable()
class EmpDowraDetModel {
  final int? maxId;
  final int? empId;
  final int? dowraId;

  final String? empName;
  final double? salary;
  final double? draga;
  final String? fia;
  final double? naqlBadal;
  final int? mokafaa;
  final int? badalEntidab;
  final int? badalTransfare;
  final int? ticketCost;

  final int? total;

  EmpDowraDetModel({
    this.maxId,
    this.empId,
    this.dowraId,
    this.empName,
    this.salary,
    this.draga,
    this.fia,
    this.naqlBadal,
    this.mokafaa,
    this.badalEntidab,
    this.badalTransfare,
    this.ticketCost,
    this.total,
  });

  factory EmpDowraDetModel.fromJson(Map<String, dynamic> json) =>
      _$EmpDowraDetModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpDowraDetModelToJson(this);
}
