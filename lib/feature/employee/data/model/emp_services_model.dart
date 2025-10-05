import 'package:json_annotation/json_annotation.dart';

part 'emp_services_model.g.dart';

@JsonSerializable()
class EmpServicesModel {
  final int? id;
  final int? empId;
  final String? job;
  final String? martaba;
  final String? mnum; // mNum
  final double? salary;
  final String? place;
  final String? datB;
  final String? datE;
  final String? reasons;
  final String? amrNo;
  final String? datAmr;
  final String? nots;

  EmpServicesModel({
    this.id,
    this.empId,
    this.job,
    this.martaba,
    this.mnum,
    this.salary,
    this.place,
    this.datB,
    this.datE,
    this.reasons,
    this.amrNo,
    this.datAmr,
    this.nots,
  });

  factory EmpServicesModel.fromJson(Map<String, dynamic> json) =>
      _$EmpServicesModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpServicesModelToJson(this);
}
