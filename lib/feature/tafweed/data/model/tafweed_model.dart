import 'package:json_annotation/json_annotation.dart';

part 'tafweed_model.g.dart';

@JsonSerializable()
class TafweedModel {
  final int? id;
  final String? subject;
  final int? empId;
  final String? day;
  final String? startDate;
  final String? endDate;
  final String? note;
  final String? computerName;
  final String? computerUser;
  final String? programUser;
  final String? inputDate;

  TafweedModel({
    this.id,
    this.subject,
    this.empId,
    this.day,
    this.startDate,
    this.endDate,
    this.note,
    this.computerName,
    this.computerUser,
    this.programUser,
    this.inputDate,
  });

  factory TafweedModel.fromJson(Map<String, dynamic> json) =>
      _$TafweedModelFromJson(json);

  Map<String, dynamic> toJson() => _$TafweedModelToJson(this);
}

@JsonSerializable()
class TafweedSearchModel {
  final int? id; // رقم التفويض
  final String? employeeName; // الاسم
  final String? startDate; // تاريخ البداية
  final String? endDate; // تاريخ النهاية
  final String? subject; // الموضوع

  TafweedSearchModel({
    this.id,
    this.employeeName,
    this.startDate,
    this.endDate,
    this.subject,
  });

  factory TafweedSearchModel.fromJson(Map<String, dynamic> json) =>
      _$TafweedSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$TafweedSearchModelToJson(this);
}

@JsonSerializable()
class TafweedReportModel {
  final int? id; // رقم التفويض
  final String? employeeName; // الاسم
  final String? startDate; // تاريخ البداية
  final String? endDate; // تاريخ النهاية
  final String? subject; // الموضوع

  TafweedReportModel({
    this.id,
    this.employeeName,
    this.startDate,
    this.endDate,
    this.subject,
  });

  factory TafweedReportModel.fromJson(Map<String, dynamic> json) =>
      _$TafweedReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$TafweedReportModelToJson(this);
}
