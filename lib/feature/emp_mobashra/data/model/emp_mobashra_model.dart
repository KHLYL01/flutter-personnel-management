import 'package:json_annotation/json_annotation.dart';

part 'emp_mobashra_model.g.dart';

@JsonSerializable()
class EmpMobashraModel {
  final int? id;
  final String? qrarId;
  final String? qrarDateString;
  final int? empId;
  final String? holidayStartDate;
  final String? holidayEndDate;
  final double? period;
  final String? khetabDate;
  final String? partBoss;
  final String? mobashraDate;
  final String? day;
  final String? notes;
  final String? qrarDate;
  final String? mobashraDateGo;
  final String? endDate;
  final double? days;
  final String? forr;
  final String? computerName;
  final String? computerUser;
  final String? programUser;
  final String? inputDate;
  final String? khetabNo;
  final String? date;
  final String? no;

  EmpMobashraModel({
    this.id,
    this.qrarId,
    this.qrarDateString,
    this.empId,
    this.holidayStartDate,
    this.holidayEndDate,
    this.period,
    this.khetabDate,
    this.partBoss,
    this.mobashraDate,
    this.day,
    this.notes,
    this.qrarDate,
    this.mobashraDateGo,
    this.endDate,
    this.days,
    this.forr,
    this.computerName,
    this.computerUser,
    this.programUser,
    this.inputDate,
    this.khetabNo,
    this.date,
    this.no,
  });

  factory EmpMobashraModel.fromJson(Map<String, dynamic> json) =>
      _$EmpMobashraModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpMobashraModelToJson(this);
}

@JsonSerializable()
class EmpMobashraSearchModel {
  final int? id; // EMP_MOBASHRA.ID
  final String? employeeName; // الاســـم
  final String? jobName; // الوظيفة
  final String? cardId; // رقم السجل / الإقامة
  final String? fia; // المرتبة / الفئة
  final double? draga; // الدرجة
  final double? salary; // الراتب
  final double? naqlBadal; // بدل النقل

  EmpMobashraSearchModel({
    this.id,
    this.employeeName,
    this.jobName,
    this.cardId,
    this.fia,
    this.draga,
    this.salary,
    this.naqlBadal,
  });

  factory EmpMobashraSearchModel.fromJson(Map<String, dynamic> json) =>
      _$EmpMobashraSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpMobashraSearchModelToJson(this);
}

@JsonSerializable()
class EmpMobashraReportModel {
  final int? id;
  final String? employeeName;
  final String? jobName;
  final String? cardId;
  final String? fia;
  final double? draga;
  final double? salary;
  final double? naqlBadal;
  final String? datMobashra;

  EmpMobashraReportModel({
    this.id,
    this.employeeName,
    this.jobName,
    this.cardId,
    this.fia,
    this.draga,
    this.salary,
    this.naqlBadal,
    this.datMobashra,
  });

  factory EmpMobashraReportModel.fromJson(Map<String, dynamic> json) =>
      _$EmpMobashraReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpMobashraReportModelToJson(this);
}
