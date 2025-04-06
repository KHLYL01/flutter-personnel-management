import 'package:json_annotation/json_annotation.dart';

part 'emp_taeen_model.g.dart';

@JsonSerializable()
class EmpTaeenModel {
  final int? id;
  final String? qrarId;
  final String? qrarDate;
  final int? empId;
  final String? birthDate;
  final int? state;
  final int? gender;
  final String? socialNumber;
  final String? khetabId;
  final String? khetabDate;
  final String? khetabName;
  final String? mKhetabDate;
  final String? mDay;

  EmpTaeenModel({
    this.id,
    this.qrarId,
    this.qrarDate,
    this.empId,
    this.birthDate,
    this.state,
    this.gender,
    this.socialNumber,
    this.khetabId,
    this.khetabDate,
    this.khetabName,
    this.mKhetabDate,
    this.mDay,
  });

  factory EmpTaeenModel.fromJson(Map<String, dynamic> json) =>
      _$EmpTaeenModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpTaeenModelToJson(this);
}

@JsonSerializable()
class EmpTaeenSearchModel {
  final int? id; // EMP_TAEEN.ID
  final String? qrarId; // رقم القرار
  final String? qrarDate; // تاريخ القرار
  final String? employeeName; // اسم الموظف
  final String? socialInsuranceNo; // رقم التأمين الاجتماعي
  final String? directDate; // يوم المباشرة

  EmpTaeenSearchModel({
    this.id,
    this.qrarId,
    this.qrarDate,
    this.employeeName,
    this.socialInsuranceNo,
    this.directDate,
  });

  factory EmpTaeenSearchModel.fromJson(Map<String, dynamic> json) =>
      _$EmpTaeenSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpTaeenSearchModelToJson(this);
}
