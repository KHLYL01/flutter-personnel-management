import 'package:json_annotation/json_annotation.dart';

part 'emp_takleef_model.g.dart';

@JsonSerializable()
class EmpTakleefModel {
  final int? id;
  final String? qrarId;
  final String? datQrar;
  final String? datQrarGo;
  final int? empId;
  final String? place;
  final String? task;
  final int? period;
  final String? khetabId;
  final String? datKhetab;
  final String? datBegin;
  final String? day;
  final double? hoursAvg;
  final String? datKhetabGo;
  final String? datBeginGo;
  final String? mrtaba;
  final double? draga;
  final double? salary;
  final double? naqlBadal;
  final String? datEnd;
  final String? computerUser;
  final String? computerName;
  final String? programUser;
  final String? inDate;
  final int? periodOthersDay;
  final double? hoursAvgOthersDay;
  final String? datEndGo;

  EmpTakleefModel({
    this.id,
    this.qrarId,
    this.datQrar,
    this.datQrarGo,
    this.empId,
    this.place,
    this.task,
    this.period,
    this.khetabId,
    this.datKhetab,
    this.datBegin,
    this.day,
    this.hoursAvg,
    this.datKhetabGo,
    this.datBeginGo,
    this.mrtaba,
    this.draga,
    this.salary,
    this.naqlBadal,
    this.datEnd,
    this.computerUser,
    this.computerName,
    this.programUser,
    this.inDate,
    this.periodOthersDay,
    this.hoursAvgOthersDay,
    this.datEndGo,
  });

  factory EmpTakleefModel.fromJson(Map<String, dynamic> json) =>
      _$EmpTakleefModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpTakleefModelToJson(this);
}

@JsonSerializable()
class EmpTakleefSearchModel {
  final int? id; // EMP_TAKLEEF.ID
  final String? cardId; // رقم السجل المدني
  final String? employeeName; // الاسم
  final String? jobName; // مسمى الوظيفة
  final double? hoursAvg; // معدل عدد ساعات
  final int? period; // عدد أيام الخارج الدوام
  final String? dateBegin; // تاريخ بداية الخارج الدوام
  final String? place; // مكان العمل (added for filtering)

  EmpTakleefSearchModel({
    this.id,
    this.cardId,
    this.employeeName,
    this.jobName,
    this.hoursAvg,
    this.period,
    this.dateBegin,
    this.place,
  });

  factory EmpTakleefSearchModel.fromJson(Map<String, dynamic> json) =>
      _$EmpTakleefSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpTakleefSearchModelToJson(this);
}

@JsonSerializable()
class EmpTakleefReportModel {
  final int? id;
  final String? employeeName; // الاسم
  final String? jobName; // مسمى الوظيفة
  final String? fia;
  final String? place; // مكان العمل (added for filtering)
  final String? task;
  final int? period; // عدد أيام الخارج الدوام
  final double? hoursAvg; // معدل عدد ساعات
  final double? hoursPeriodTotal; // معدل عدد ساعات
  final String? dateBegin; // تاريخ بداية الخارج الدوام

  EmpTakleefReportModel({
    this.id,
    this.employeeName,
    this.jobName,
    this.fia,
    this.place,
    this.task,
    this.period,
    this.hoursAvg,
    this.hoursPeriodTotal,
    this.dateBegin,
  });

  factory EmpTakleefReportModel.fromJson(Map<String, dynamic> json) =>
      _$EmpTakleefReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpTakleefReportModelToJson(this);
}
