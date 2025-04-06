// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_dowra_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpDowraModel _$EmpDowraModelFromJson(Map<String, dynamic> json) =>
    EmpDowraModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      footer: json['footer'] as String?,
      courseDays: (json['courseDays'] as num?)?.toInt(),
      extraDays: (json['extraDays'] as num?)?.toInt(),
      countryId: (json['countryId'] as num?)?.toInt(),
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      decisionNumber: json['decisionNumber'] as String?,
      decisionDate: json['decisionDate'] as String?,
    );

Map<String, dynamic> _$EmpDowraModelToJson(EmpDowraModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'footer': instance.footer,
      'courseDays': instance.courseDays,
      'extraDays': instance.extraDays,
      'countryId': instance.countryId,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'decisionNumber': instance.decisionNumber,
      'decisionDate': instance.decisionDate,
    };

EmpDowraSearchModel _$EmpDowraSearchModelFromJson(Map<String, dynamic> json) =>
    EmpDowraSearchModel(
      dowraId: (json['dowraId'] as num?)?.toInt(),
      employeeName: json['employeeName'] as String?,
      fia: json['fia'] as String?,
      draga: (json['draga'] as num?)?.toDouble(),
      salary: (json['salary'] as num?)?.toDouble(),
      naqlBadal: (json['naqlBadal'] as num?)?.toDouble(),
      jobName: json['jobName'] as String?,
    );

Map<String, dynamic> _$EmpDowraSearchModelToJson(
        EmpDowraSearchModel instance) =>
    <String, dynamic>{
      'dowraId': instance.dowraId,
      'employeeName': instance.employeeName,
      'fia': instance.fia,
      'draga': instance.draga,
      'salary': instance.salary,
      'naqlBadal': instance.naqlBadal,
      'jobName': instance.jobName,
    };
