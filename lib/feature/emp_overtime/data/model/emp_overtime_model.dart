import 'package:json_annotation/json_annotation.dart';

part 'emp_overtime_model.g.dart';

@JsonSerializable()
class EmpOvertimeModel {
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

  EmpOvertimeModel({
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

  factory EmpOvertimeModel.fromJson(Map<String, dynamic> json) =>
      _$EmpOvertimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpOvertimeModelToJson(this);
}

@JsonSerializable()
class EmpOvertimeSearchModel {
  final int? id; // EMP_OVERTIME.ID
  final String? cardId; // رقم السجل المدني
  final String? employeeName; // الاسم
  final String? jobName; // مسمى الوظيفة
  final double? hoursAvg; // معدل عدد ساعات
  final int? period; // عدد أيام الخارج الدوام
  final String? dateBegin; // تاريخ بداية الخارج الدوام
  final String? place; // مكان العمل (added for filtering)

  EmpOvertimeSearchModel({
    this.id,
    this.cardId,
    this.employeeName,
    this.jobName,
    this.hoursAvg,
    this.period,
    this.dateBegin,
    this.place,
  });

  factory EmpOvertimeSearchModel.fromJson(Map<String, dynamic> json) =>
      _$EmpOvertimeSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpOvertimeSearchModelToJson(this);
}
