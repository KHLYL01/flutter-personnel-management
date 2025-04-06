import 'package:json_annotation/json_annotation.dart';

part 'emp_dowra_model.g.dart';

@JsonSerializable()
class EmpDowraModel {
  final int? id;
  final String? title;
  final String? footer;
  final int? courseDays;
  final int? extraDays;
  final int? countryId;
  final String? startDate;
  final String? endDate;
  final String? decisionNumber;
  final String? decisionDate;

  EmpDowraModel({
    this.id,
    this.title,
    this.footer,
    this.courseDays,
    this.extraDays,
    this.countryId,
    this.startDate,
    this.endDate,
    this.decisionNumber,
    this.decisionDate,
  });

  factory EmpDowraModel.fromJson(Map<String, dynamic> json) =>
      _$EmpDowraModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpDowraModelToJson(this);
}

@JsonSerializable()
class EmpDowraSearchModel {
  final int? dowraId; // DOWRAID
  final String? employeeName; // اسم الموظف
  final String? fia; // المرتبة
  final double? draga; // الدرجة
  final double? salary; // الراتب
  final double? naqlBadal; // بدل النقل
  final String? jobName; // الوظيفة

  EmpDowraSearchModel({
    this.dowraId,
    this.employeeName,
    this.fia,
    this.draga,
    this.salary,
    this.naqlBadal,
    this.jobName,
  });

  factory EmpDowraSearchModel.fromJson(Map<String, dynamic> json) =>
      _$EmpDowraSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpDowraSearchModelToJson(this);
}
