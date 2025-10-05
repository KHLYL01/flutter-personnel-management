import 'package:json_annotation/json_annotation.dart';

part 'emp_eqrar_model.g.dart';

@JsonSerializable()
class EmpEqrarModel {
  final int? id;
  final int? letterNumber;
  final String? letterName;
  final String? decisionName;
  final String? decisionPlace;
  final String? decisionDate;
  final String? letterDate;
  final String? computerName;
  final String? computerUser;
  final String? programUser;
  final String? inputDate;

  EmpEqrarModel({
    this.id,
    this.letterNumber,
    this.letterName,
    this.decisionName,
    this.decisionPlace,
    this.decisionDate,
    this.letterDate,
    this.computerName,
    this.computerUser,
    this.programUser,
    this.inputDate,
  });

  factory EmpEqrarModel.fromJson(Map<String, dynamic> json) =>
      _$EmpEqrarModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpEqrarModelToJson(this);
}

@JsonSerializable()
class EmpEqrarSearchModel {
  final int? id; //رقم الإقرار
  final String? eqrarName; //اسم المقر
  final String? eqrarDate; //تاريخ الإقرار
  final String? eqrarPlace; //مكان الحضور
  final int? khetabNumber; //رقم الخطاب
  final String? khetabName; //مرسل الخطاب
  final String? khetabDate; //تاريخ الخطاب

  EmpEqrarSearchModel({
    this.id,
    this.eqrarName,
    this.eqrarDate,
    this.eqrarPlace,
    this.khetabNumber,
    this.khetabName,
    this.khetabDate,
  });

  factory EmpEqrarSearchModel.fromJson(Map<String, dynamic> json) =>
      _$EmpEqrarSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpEqrarSearchModelToJson(this);
}

@JsonSerializable()
class EmpEqrarReportModel {
  final int? id; //رقم الإقرار
  final String? eqrarName; //اسم المقر
  final String? eqrarDate; //تاريخ الإقرار
  final String? eqrarPlace; //مكان الحضور
  final int? khetabNumber; //رقم الخطاب
  final String? khetabName; //مرسل الخطاب
  final String? khetabDate; //تاريخ الخطاب

  EmpEqrarReportModel({
    this.id,
    this.eqrarName,
    this.eqrarDate,
    this.eqrarPlace,
    this.khetabNumber,
    this.khetabName,
    this.khetabDate,
  });

  factory EmpEqrarReportModel.fromJson(Map<String, dynamic> json) =>
      _$EmpEqrarReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpEqrarReportModelToJson(this);
}
