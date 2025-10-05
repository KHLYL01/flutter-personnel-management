import 'package:json_annotation/json_annotation.dart';

part 'emp_entedab_model.g.dart';

@JsonSerializable()
class EmpEntedabModel {
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
  final double? taskRaValue;
  final int? sarf;
  final int? taskRa;
  final String? datKhetabGo;
  final String? datBeginGo;
  final String? mrtaba;
  final double? draga;
  final double? salary;
  final double? naqlBadal;
  final double? entedabBadal;
  final String? datEnd;
  final String? waselTsafar;
  final double? distance;
  final int? question1;
  final int? question2;
  final int? question3;
  final int? question4;
  final int? question5;
  final String? computerName;
  final String? computerUser;
  final String? programUser;
  final String? inDate;
  final int? threeDays;
  final int? entedabType;
  final int? prentedEstehqaq;
  final int? prentedErcab;
  final String? waselatSafar;
  final int? prentedErca;
  final String? khat;
  final String? daragaPlan;
  final String? eshaar;
  final int? ext;
  final int? before;
  final int? after;
  final String? type;
  final String? fia;
  final double? fiaMony;
  final String? datEndGo;

  EmpEntedabModel({
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
    this.taskRaValue,
    this.sarf,
    this.taskRa,
    this.datKhetabGo,
    this.datBeginGo,
    this.mrtaba,
    this.draga,
    this.salary,
    this.naqlBadal,
    this.entedabBadal,
    this.datEnd,
    this.waselTsafar,
    this.distance,
    this.question1,
    this.question2,
    this.question3,
    this.question4,
    this.question5,
    this.computerName,
    this.computerUser,
    this.programUser,
    this.inDate,
    this.threeDays,
    this.entedabType,
    this.prentedEstehqaq,
    this.prentedErcab,
    this.waselatSafar,
    this.prentedErca,
    this.khat,
    this.daragaPlan,
    this.eshaar,
    this.ext,
    this.before,
    this.after,
    this.type,
    this.fia,
    this.fiaMony,
    this.datEndGo,
  });

  factory EmpEntedabModel.fromJson(Map<String, dynamic> json) =>
      _$EmpEntedabModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpEntedabModelToJson(this);
}

@JsonSerializable()
class EmpEntedabSearchModel {
  final int? id; // EMP_ENTEDAB.ID
  final String? cardId; // رقم السجل المدني
  final String? employeeName; // الاسم
  final String? jobTitle; // مسمى الوظيفة
  final String? entedabPlace; // جهة الإنتداب
  final int? period; // المدة
  final String? assignmentStartDate; // تاريخ بداية الإنتداب

  EmpEntedabSearchModel({
    this.id,
    this.cardId,
    this.employeeName,
    this.jobTitle,
    this.entedabPlace,
    this.period,
    this.assignmentStartDate,
  });

  factory EmpEntedabSearchModel.fromJson(Map<String, dynamic> json) =>
      _$EmpEntedabSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpEntedabSearchModelToJson(this);
}

@JsonSerializable()
class EmpEntedabReportModel {
  final int? id; // EMP_ENTEDAB.ID
  final String? employeeName; // الاسم
  final String? jobTitle; // مسمى الوظيفة
  final String? fia;
  final String? entedabPlace; // جهة الإنتداب
  final String? task;
  final int? period; // المدة
  final String? assignmentStartDate; // تاريخ بداية الإنتداب
  final int? prevPeriod;
  final int? sumPeriod;
  final int? empId;
  final String? dateBeginGo;

  EmpEntedabReportModel({
    this.id,
    this.employeeName,
    this.jobTitle,
    this.fia,
    this.entedabPlace,
    this.task,
    this.period,
    this.assignmentStartDate,
    this.prevPeriod,
    this.sumPeriod,
    this.empId,
    this.dateBeginGo,
  });

  factory EmpEntedabReportModel.fromJson(Map<String, dynamic> json) =>
      _$EmpEntedabReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpEntedabReportModelToJson(this);
}
