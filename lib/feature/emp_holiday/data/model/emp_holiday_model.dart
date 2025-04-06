import 'package:json_annotation/json_annotation.dart';

part 'emp_holiday_model.g.dart';

@JsonSerializable()
class EmpHolidayModel {
  final int? id;
  final int? empId;
  final String? mrtaba;
  final double? draga;
  final double? salary;
  final double? naqlBadal;
  final String? requestDateString;
  final String? requestDate;
  final int? holidayType;
  final double? period;
  final String? address;
  final int? sarf;
  final String? boss;
  final String? bossJob;
  final String? qrarId;
  final String? qrarDateString;
  final String? qrarDate;
  final String? startDateString;
  final String? startDate;
  final String? endDateString;
  final String? endDate;
  final String? eligibilityStartDate;
  final String? eligibilityEndDate;
  final String? separationDate;
  final String? computerName;
  final String? computerUser;
  final String? programUser;
  final String? inputDate;

  final String? tebyPlace;
  final String? tebyBase;
  final String? forr;
  final int? prev;
  final String? sejel;
  final String? sejelDate;
  final String? morafeq;
  final String? esaba;
  final int? extensionPeriod;
  final String? extensionStartDate;
  final String? badeel;
  final int? mostahaka;
  final int? directBoss;
  final int? salahea;
  final int? car;
  final int? carTasleem;
  final String? spare;
  final String? fileNo;
  final String? extensionEndDate;
  final int? cancel;
  final String? tepyNo;
  final String? tepyDate;
  final String? hospital;
  final int? etemad;
  final String? edara;
  final String? footer;
  final String? requestYear;
  final int? holidayYear;
  final int? holidayYearExtension;
  final int? holidayCategory;
  final int? holidayCategoryExtension;

  EmpHolidayModel({
    this.id,
    this.empId,
    this.mrtaba,
    this.draga,
    this.salary,
    this.naqlBadal,
    this.requestDateString,
    this.requestDate,
    this.holidayType,
    this.period,
    this.address,
    this.sarf,
    this.boss,
    this.bossJob,
    this.qrarId,
    this.qrarDateString,
    this.qrarDate,
    this.startDateString,
    this.startDate,
    this.endDateString,
    this.endDate,
    this.eligibilityStartDate,
    this.eligibilityEndDate,
    this.separationDate,
    this.computerName,
    this.computerUser,
    this.programUser,
    this.inputDate,
    this.tebyPlace,
    this.tebyBase,
    this.forr,
    this.prev,
    this.sejel,
    this.sejelDate,
    this.morafeq,
    this.esaba,
    this.extensionPeriod,
    this.extensionStartDate,
    this.badeel,
    this.mostahaka,
    this.directBoss,
    this.salahea,
    this.car,
    this.carTasleem,
    this.spare,
    this.fileNo,
    this.extensionEndDate,
    this.cancel,
    this.tepyNo,
    this.tepyDate,
    this.hospital,
    this.etemad,
    this.edara,
    this.footer,
    this.requestYear,
    this.holidayYear,
    this.holidayYearExtension,
    this.holidayCategory,
    this.holidayCategoryExtension,
  });

  factory EmpHolidayModel.fromJson(Map<String, dynamic> json) =>
      _$EmpHolidayModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpHolidayModelToJson(this);
}

@JsonSerializable()
class EmpHolidaySearchModel {
  final int? id; // EMP_HOLIDAYS.ID
  final String? startDate; // EMP_HOLIDAYS.DATBEGINGO
  final String? cardId; // رقم السجل المدني
  final String? employeeName; // الاسم
  final String? jobName; // مسمى الوظيفة
  final int? holidayType; // نوع الإجازة
  final String? holidayStartDate; // تاريخ بداية الإجازة
  final String? holidayEndDate; // تاريخ انتهاء الاجازة
  final double? period; // مدة الإجازة
  final String? employmentType; // نوع الوظيفة
  final int? etemad; // الاعتماد (نعم/لا)

  EmpHolidaySearchModel({
    this.id,
    this.startDate,
    this.cardId,
    this.employeeName,
    this.jobName,
    this.holidayType,
    this.holidayStartDate,
    this.holidayEndDate,
    this.period,
    this.employmentType,
    this.etemad,
  });

  factory EmpHolidaySearchModel.fromJson(Map<String, dynamic> json) =>
      _$EmpHolidaySearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpHolidaySearchModelToJson(this);
}
