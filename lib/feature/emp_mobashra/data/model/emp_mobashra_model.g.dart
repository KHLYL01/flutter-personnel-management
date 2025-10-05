// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_mobashra_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpMobashraModel _$EmpMobashraModelFromJson(Map<String, dynamic> json) =>
    EmpMobashraModel(
      id: (json['id'] as num?)?.toInt(),
      qrarId: json['qrarId'] as String?,
      qrarDateString: json['qrarDateString'] as String?,
      empId: (json['empId'] as num?)?.toInt(),
      holidayStartDate: json['holidayStartDate'] as String?,
      holidayEndDate: json['holidayEndDate'] as String?,
      period: (json['period'] as num?)?.toDouble(),
      khetabDate: json['khetabDate'] as String?,
      partBoss: json['partBoss'] as String?,
      mobashraDate: json['mobashraDate'] as String?,
      day: json['day'] as String?,
      notes: json['notes'] as String?,
      qrarDate: json['qrarDate'] as String?,
      mobashraDateGo: json['mobashraDateGo'] as String?,
      endDate: json['endDate'] as String?,
      days: (json['days'] as num?)?.toDouble(),
      forr: json['forr'] as String?,
      computerName: json['computerName'] as String?,
      computerUser: json['computerUser'] as String?,
      programUser: json['programUser'] as String?,
      inputDate: json['inputDate'] as String?,
      khetabNo: json['khetabNo'] as String?,
      date: json['date'] as String?,
      no: json['no'] as String?,
    );

Map<String, dynamic> _$EmpMobashraModelToJson(EmpMobashraModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qrarId': instance.qrarId,
      'qrarDateString': instance.qrarDateString,
      'empId': instance.empId,
      'holidayStartDate': instance.holidayStartDate,
      'holidayEndDate': instance.holidayEndDate,
      'period': instance.period,
      'khetabDate': instance.khetabDate,
      'partBoss': instance.partBoss,
      'mobashraDate': instance.mobashraDate,
      'day': instance.day,
      'notes': instance.notes,
      'qrarDate': instance.qrarDate,
      'mobashraDateGo': instance.mobashraDateGo,
      'endDate': instance.endDate,
      'days': instance.days,
      'forr': instance.forr,
      'computerName': instance.computerName,
      'computerUser': instance.computerUser,
      'programUser': instance.programUser,
      'inputDate': instance.inputDate,
      'khetabNo': instance.khetabNo,
      'date': instance.date,
      'no': instance.no,
    };

EmpMobashraSearchModel _$EmpMobashraSearchModelFromJson(
        Map<String, dynamic> json) =>
    EmpMobashraSearchModel(
      id: (json['id'] as num?)?.toInt(),
      employeeName: json['employeeName'] as String?,
      jobName: json['jobName'] as String?,
      cardId: json['cardId'] as String?,
      fia: json['fia'] as String?,
      draga: (json['draga'] as num?)?.toDouble(),
      salary: (json['salary'] as num?)?.toDouble(),
      naqlBadal: (json['naqlBadal'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EmpMobashraSearchModelToJson(
        EmpMobashraSearchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeName': instance.employeeName,
      'jobName': instance.jobName,
      'cardId': instance.cardId,
      'fia': instance.fia,
      'draga': instance.draga,
      'salary': instance.salary,
      'naqlBadal': instance.naqlBadal,
    };

EmpMobashraReportModel _$EmpMobashraReportModelFromJson(
        Map<String, dynamic> json) =>
    EmpMobashraReportModel(
      id: (json['id'] as num?)?.toInt(),
      employeeName: json['employeeName'] as String?,
      jobName: json['jobName'] as String?,
      cardId: json['cardId'] as String?,
      fia: json['fia'] as String?,
      draga: (json['draga'] as num?)?.toDouble(),
      salary: (json['salary'] as num?)?.toDouble(),
      naqlBadal: (json['naqlBadal'] as num?)?.toDouble(),
      datMobashra: json['datMobashra'] as String?,
    );

Map<String, dynamic> _$EmpMobashraReportModelToJson(
        EmpMobashraReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeName': instance.employeeName,
      'jobName': instance.jobName,
      'cardId': instance.cardId,
      'fia': instance.fia,
      'draga': instance.draga,
      'salary': instance.salary,
      'naqlBadal': instance.naqlBadal,
      'datMobashra': instance.datMobashra,
    };
