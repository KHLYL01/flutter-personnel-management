// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_overtime_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpOvertimeModel _$EmpOvertimeModelFromJson(Map<String, dynamic> json) =>
    EmpOvertimeModel(
      id: (json['id'] as num?)?.toInt(),
      qrarId: json['qrarId'] as String?,
      datQrar: json['datQrar'] as String?,
      datQrarGo: json['datQrarGo'] as String?,
      empId: (json['empId'] as num?)?.toInt(),
      place: json['place'] as String?,
      task: json['task'] as String?,
      period: (json['period'] as num?)?.toInt(),
      khetabId: json['khetabId'] as String?,
      datKhetab: json['datKhetab'] as String?,
      datBegin: json['datBegin'] as String?,
      day: json['day'] as String?,
      hoursAvg: (json['hoursAvg'] as num?)?.toDouble(),
      datKhetabGo: json['datKhetabGo'] as String?,
      datBeginGo: json['datBeginGo'] as String?,
      mrtaba: json['mrtaba'] as String?,
      draga: (json['draga'] as num?)?.toDouble(),
      salary: (json['salary'] as num?)?.toDouble(),
      naqlBadal: (json['naqlBadal'] as num?)?.toDouble(),
      datEnd: json['datEnd'] as String?,
      computerUser: json['computerUser'] as String?,
      computerName: json['computerName'] as String?,
      programUser: json['programUser'] as String?,
      inDate: json['inDate'] as String?,
      periodOthersDay: (json['periodOthersDay'] as num?)?.toInt(),
      hoursAvgOthersDay: (json['hoursAvgOthersDay'] as num?)?.toDouble(),
      datEndGo: json['datEndGo'] as String?,
    );

Map<String, dynamic> _$EmpOvertimeModelToJson(EmpOvertimeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qrarId': instance.qrarId,
      'datQrar': instance.datQrar,
      'datQrarGo': instance.datQrarGo,
      'empId': instance.empId,
      'place': instance.place,
      'task': instance.task,
      'period': instance.period,
      'khetabId': instance.khetabId,
      'datKhetab': instance.datKhetab,
      'datBegin': instance.datBegin,
      'day': instance.day,
      'hoursAvg': instance.hoursAvg,
      'datKhetabGo': instance.datKhetabGo,
      'datBeginGo': instance.datBeginGo,
      'mrtaba': instance.mrtaba,
      'draga': instance.draga,
      'salary': instance.salary,
      'naqlBadal': instance.naqlBadal,
      'datEnd': instance.datEnd,
      'computerUser': instance.computerUser,
      'computerName': instance.computerName,
      'programUser': instance.programUser,
      'inDate': instance.inDate,
      'periodOthersDay': instance.periodOthersDay,
      'hoursAvgOthersDay': instance.hoursAvgOthersDay,
      'datEndGo': instance.datEndGo,
    };

EmpOvertimeSearchModel _$EmpOvertimeSearchModelFromJson(
        Map<String, dynamic> json) =>
    EmpOvertimeSearchModel(
      id: (json['id'] as num?)?.toInt(),
      cardId: json['cardId'] as String?,
      employeeName: json['employeeName'] as String?,
      jobName: json['jobName'] as String?,
      hoursAvg: (json['hoursAvg'] as num?)?.toDouble(),
      period: (json['period'] as num?)?.toInt(),
      dateBegin: json['dateBegin'] as String?,
      place: json['place'] as String?,
    );

Map<String, dynamic> _$EmpOvertimeSearchModelToJson(
        EmpOvertimeSearchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardId': instance.cardId,
      'employeeName': instance.employeeName,
      'jobName': instance.jobName,
      'hoursAvg': instance.hoursAvg,
      'period': instance.period,
      'dateBegin': instance.dateBegin,
      'place': instance.place,
    };
