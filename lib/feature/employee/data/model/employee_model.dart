import 'package:json_annotation/json_annotation.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class EmployeeModel {
  final int? id;
  final int? degreeId;
  final double? jobbadalat;
  final int? jobId;
  final String? symble;
  final int? partId;
  final String? datJob;
  final String? datJobGo;
  final String? name;
  final int? nationId;
  final String? cardId;
  final String? bok;
  final String? bokPlace;
  final String? datBok;
  final String? datBokGo;
  final String? datBirth;
  final String? datBirthGo;
  final String? birthPlace;
  final String? datWork;
  final String? datWorkGo;
  final String? education;
  final String? educationName;
  final String? datEducation;
  final String? datEducationGo;
  final String? address;
  final String? phone;
  final String? workJob;
  final String? empType;
  final String? fia;
  final double? draga;
  final double? salary;
  final double? naqlBadal;
  final int? takenHolidays;
  final int? jobNo;
  final double? elawa;
  final double? inEntedabBadal;
  final double? outEntedabBadal;
  final String? jobState;
  final String? akdNo;
  final String? datAkdBegin;
  final String? datAkdEnd;
  final String? akdEndService;
  final int? cardNo;
  final String? cardStart;
  final String? cardJob;
  final String? datQard;
  final int? qardMony;
  final int? qardQest;
  final String? computerName;
  final String? computerUser;
  final String? programUser;
  final String? inDate;
  final String? bankId;
  final String? accountNo;
  final double? quick;
  final int? salary1;
  final double? maeesha;
  final String? datTahweel;
  final double? taka3odM;
  final double? previous;
  final double? cardCount;
  final String? passportId;
  final double? nadafa;
  final String? datTykeed;
  final String? datEndGo;
  final int? badal1;
  final int? badal2;
  final int? badal3;
  final int? badal4;
  final int? hasm1;
  final int? hasm2;
  final int? isHasm3;
  final String? userIdM;
  final int? machineNumber;
  final String? dmobashrag;
  final String? dmobashrah;
  final String? ibanNum;

  final double? dissent;
  final String? akdNoTasleef;
  final String? datStartTasleef;
  final String? datEndTasleef;
  final int? qestTasleef;
  final int? moneyTasleef;
  final double? sandok;
  final String? akdNoSandok;
  final String? datStartSandok;
  final String? datEndSandok;
  final int? qestSandok;
  final int? moneySandok;
  final double? zeraee;
  final String? akdNoZeraee;
  final String? datStartZeraee;
  final String? datEndZeraee;
  final int? qestZeraee;
  final int? moneyZeraee;

  EmployeeModel({
    this.id,
    this.degreeId,
    this.jobbadalat,
    this.jobId,
    this.symble,
    this.partId,
    this.datJob,
    this.datJobGo,
    this.name,
    this.nationId,
    this.cardId,
    this.bok,
    this.bokPlace,
    this.datBok,
    this.datBokGo,
    this.datBirth,
    this.datBirthGo,
    this.birthPlace,
    this.datWork,
    this.datWorkGo,
    this.education,
    this.educationName,
    this.datEducation,
    this.datEducationGo,
    this.address,
    this.phone,
    this.workJob,
    this.empType,
    this.fia,
    this.draga,
    this.salary,
    this.naqlBadal,
    this.takenHolidays,
    this.jobNo,
    this.elawa,
    this.inEntedabBadal,
    this.outEntedabBadal,
    this.jobState,
    this.akdNo,
    this.datAkdBegin,
    this.datAkdEnd,
    this.akdEndService,
    this.cardNo,
    this.cardStart,
    this.cardJob,
    this.datQard,
    this.qardMony,
    this.qardQest,
    this.computerName,
    this.computerUser,
    this.programUser,
    this.inDate,
    this.bankId,
    this.accountNo,
    this.quick,
    this.salary1,
    this.maeesha,
    this.datTahweel,
    this.taka3odM,
    this.previous,
    this.cardCount,
    this.passportId,
    this.nadafa,
    this.datTykeed,
    this.datEndGo,
    this.badal1,
    this.badal2,
    this.badal3,
    this.badal4,
    this.hasm1,
    this.hasm2,
    this.isHasm3,
    this.userIdM,
    this.machineNumber,
    this.dmobashrag,
    this.dmobashrah,
    this.ibanNum,
    this.dissent,
    this.akdNoTasleef,
    this.datStartTasleef,
    this.datEndTasleef,
    this.qestTasleef,
    this.moneyTasleef,
    this.sandok,
    this.akdNoSandok,
    this.datStartSandok,
    this.datEndSandok,
    this.qestSandok,
    this.moneySandok,
    this.zeraee,
    this.akdNoZeraee,
    this.datStartZeraee,
    this.datEndZeraee,
    this.qestZeraee,
    this.moneyZeraee,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);
}

@JsonSerializable()
class EmployeeSearchModel {
  final int? id;
  final String? name;
  final String? cardId;
  final int? jobId;
  final String? jobName;
  final int? partId;
  final String? partName;
  final String? fia;
  final double? salary;
  final double? draga;
  final String? jobState;
  final String? workJob;

  EmployeeSearchModel({
    this.id,
    this.name,
    this.cardId,
    this.jobId,
    this.jobName,
    this.partId,
    this.partName,
    this.fia,
    this.salary,
    this.draga,
    this.jobState,
    this.workJob,
  });

  factory EmployeeSearchModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeSearchModelToJson(this);
}

@JsonSerializable()
class EmployeeReportModel {
  final int? id;
  final String? name;
  final String? partName;
  final String? fia;
  final int? jobNo;
  final double? draga;
  final String? jobName;
  final String? jobState;
  final String? cardId;
  final String? bok; // رقم الحفيظة
  final String? datBok; //تاريخ الحفيظة
  final String? datWork;
  final String? datJob;
  final String? education;
  final double? salary;

  EmployeeReportModel({
    this.id,
    this.name,
    this.partName,
    this.fia,
    this.jobNo,
    this.draga,
    this.jobName,
    this.jobState,
    this.cardId,
    this.bok,
    this.datBok,
    this.datWork,
    this.datJob,
    this.education,
    this.salary,
  });

  factory EmployeeReportModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeReportModelToJson(this);
}

@JsonSerializable()
class EmployeeFindModel {
  final int? id; // رقم الموظف
  final String? name; // اسم الموظف
  final String? fia; // المرتبة
  final double? draga; // الدرجة
  final double? salary; // الراتب
  final double? naqlBadal; // بدل النقل
  final double? intentedabBadal; // بدل الإنتداب
  final String? empType; // نوع الوظيفة
  final int? badal1;
  final int? badal2;
  final int? badal3;
  final int? badal4;
  final double? jobBadalat;
  final double? maeesha;

  EmployeeFindModel({
    this.id,
    this.name,
    this.fia,
    this.draga,
    this.salary,
    this.naqlBadal,
    this.intentedabBadal,
    this.empType,
    this.badal1,
    this.badal2,
    this.badal3,
    this.badal4,
    this.jobBadalat,
    this.maeesha,
  });

  factory EmployeeFindModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFindModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeFindModelToJson(this);
}
