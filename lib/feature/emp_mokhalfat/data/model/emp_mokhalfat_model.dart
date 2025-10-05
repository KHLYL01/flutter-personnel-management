import 'package:json_annotation/json_annotation.dart';

part 'emp_mokhalfat_model.g.dart';

@JsonSerializable()
class EmpMokhalfatModel {
  final int? id;
  final String? mokhalfaType;
  final String? startDateString;
  final String? startDate;
  final String? endDateString;
  final String? endDate;
  final String? description;
  final String? computerName;
  final String? computerUser;
  final String? programUser;
  final String? inputDate;
  final String? requestDateString;
  final String? requestDate;

  EmpMokhalfatModel({
    this.id,
    this.mokhalfaType,
    this.startDateString,
    this.startDate,
    this.endDateString,
    this.endDate,
    this.description,
    this.computerName,
    this.computerUser,
    this.programUser,
    this.inputDate,
    this.requestDateString,
    this.requestDate,
  });

  factory EmpMokhalfatModel.fromJson(Map<String, dynamic> json) =>
      _$EmpMokhalfatModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpMokhalfatModelToJson(this);
}

@JsonSerializable()
class EmpMokhalfatSearchModel {
  final int? id; // EMP_MOKHALFAT.ID
  final String? cardId; // رقم السجل المدني
  final String? employeeName; // الاسم
  final String? jobName; // مسمى الوظيفة
  final String? periodFrom; // الفترة من
  final String? periodTo; // إلى
  final String? mokhalfaType; // النوع

  EmpMokhalfatSearchModel({
    this.id,
    this.cardId,
    this.employeeName,
    this.jobName,
    this.periodFrom,
    this.periodTo,
    this.mokhalfaType,
  });

  factory EmpMokhalfatSearchModel.fromJson(Map<String, dynamic> json) =>
      _$EmpMokhalfatSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpMokhalfatSearchModelToJson(this);
}

@JsonSerializable()
class EmpMokhalfatReportModel {
  final int? id;
  final String? employeeName;
  final String? cardId;
  final String? jobName;
  final String? fia;
  final String? periodFrom;
  final String? periodTo;
  final String? mokhalfaType;
  final double? gza;

  EmpMokhalfatReportModel({
    this.id,
    this.employeeName,
    this.cardId,
    this.jobName,
    this.fia,
    this.periodFrom,
    this.periodTo,
    this.mokhalfaType,
    this.gza,
  });

  factory EmpMokhalfatReportModel.fromJson(Map<String, dynamic> json) =>
      _$EmpMokhalfatReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpMokhalfatReportModelToJson(this);
}
