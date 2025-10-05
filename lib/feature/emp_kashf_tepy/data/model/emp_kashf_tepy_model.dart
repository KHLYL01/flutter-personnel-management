import 'package:json_annotation/json_annotation.dart';

part 'emp_kashf_tepy_model.g.dart';

@JsonSerializable()
class EmpKashfTepyModel {
  final int? id;
  final int? empId;
  final String? requestDateString;
  final String? requestDate;
  final String? wehdaType;
  final String? wehdaName;
  final String? notes;
  final String? employeeStatus;
  final String? endDateString;
  final String? endDate;
  // Audit fields
  final String? computerName;
  final String? computerUser;
  final String? programUser;
  final String? inputDate;

  EmpKashfTepyModel({
    this.id,
    this.empId,
    this.requestDateString,
    this.requestDate,
    this.wehdaType,
    this.wehdaName,
    this.notes,
    this.employeeStatus,
    this.endDateString,
    this.endDate,
    this.computerName,
    this.computerUser,
    this.programUser,
    this.inputDate,
  });

  factory EmpKashfTepyModel.fromJson(Map<String, dynamic> json) =>
      _$EmpKashfTepyModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpKashfTepyModelToJson(this);
}

@JsonSerializable()
class EmpKashfTepySearchModel {
  final int? id; // EMP_KASHFTEPY.ID
  final String? cardId; // رقم السجل المدني
  final String? employeeName; // الاسم
  final String? jobName; // مسمى الوظيفة
  final String? requestDate; // تاريخ الطلب
  final String? employeeStatus; // حالة الموظف
  final String? medicalUnitName; // اسم الوحدة الصحية

  EmpKashfTepySearchModel({
    this.id,
    this.cardId,
    this.employeeName,
    this.jobName,
    this.requestDate,
    this.employeeStatus,
    this.medicalUnitName,
  });

  factory EmpKashfTepySearchModel.fromJson(Map<String, dynamic> json) =>
      _$EmpKashfTepySearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpKashfTepySearchModelToJson(this);
}

@JsonSerializable()
class EmpKashfTepyReportModel {
  final int? id;
  final String? employeeName;
  final String? jobName;
  final String? requestDate;
  final String? medicalUnitType;
  final String? medicalUnitName;
  final String? employeeStatus;
  final String? datEnketa3;

  EmpKashfTepyReportModel({
    this.id,
    this.employeeName,
    this.jobName,
    this.requestDate,
    this.medicalUnitType,
    this.medicalUnitName,
    this.employeeStatus,
    this.datEnketa3,
  });

  factory EmpKashfTepyReportModel.fromJson(Map<String, dynamic> json) =>
      _$EmpKashfTepyReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpKashfTepyReportModelToJson(this);
}
