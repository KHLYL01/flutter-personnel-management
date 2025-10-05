// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_hasmiat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpHasmiatModel _$EmpHasmiatModelFromJson(Map<String, dynamic> json) =>
    EmpHasmiatModel(
      id: (json['id'] as num?)?.toInt(),
      qrarId: json['qrarId'] as String?,
      datQrar: json['datQrar'] as String?,
      datQrarGo: json['datQrarGo'] as String?,
      empId: (json['empId'] as num?)?.toInt(),
      mrtaba: json['mrtaba'] as String?,
      draga: (json['draga'] as num?)?.toDouble(),
      salary: (json['salary'] as num?)?.toDouble(),
      naqlBadal: (json['naqlBadal'] as num?)?.toDouble(),
      ghyab: (json['ghyab'] as num?)?.toDouble(),
      tagmee3: (json['tagmee3'] as num?)?.toDouble(),
      gza: (json['gza'] as num?)?.toDouble(),
      datBegin: json['datBegin'] as String?,
      datBeginGo: json['datBeginGo'] as String?,
      datEnd: json['datEnd'] as String?,
      datEndGo: json['datEndGo'] as String?,
      byan: json['byan'] as String?,
      computerName: json['computerName'] as String?,
      computerUser: json['computerUser'] as String?,
      programUser: json['programUser'] as String?,
      inDate: json['inDate'] as String?,
      month1: json['month1'] as String?,
      month2: json['month2'] as String?,
      year1: json['year1'] as String?,
      year2: json['year2'] as String?,
      dependOn: json['dependOn'] as String?,
      footer: json['footer'] as String?,
      hasmType: json['hasmType'] as String?,
    );

Map<String, dynamic> _$EmpHasmiatModelToJson(EmpHasmiatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qrarId': instance.qrarId,
      'datQrar': instance.datQrar,
      'datQrarGo': instance.datQrarGo,
      'empId': instance.empId,
      'mrtaba': instance.mrtaba,
      'draga': instance.draga,
      'salary': instance.salary,
      'naqlBadal': instance.naqlBadal,
      'ghyab': instance.ghyab,
      'tagmee3': instance.tagmee3,
      'gza': instance.gza,
      'datBegin': instance.datBegin,
      'datBeginGo': instance.datBeginGo,
      'datEnd': instance.datEnd,
      'datEndGo': instance.datEndGo,
      'byan': instance.byan,
      'computerName': instance.computerName,
      'computerUser': instance.computerUser,
      'programUser': instance.programUser,
      'inDate': instance.inDate,
      'month1': instance.month1,
      'month2': instance.month2,
      'year1': instance.year1,
      'year2': instance.year2,
      'dependOn': instance.dependOn,
      'footer': instance.footer,
      'hasmType': instance.hasmType,
    };

EmpHasmiatSearchModel _$EmpHasmiatSearchModelFromJson(
        Map<String, dynamic> json) =>
    EmpHasmiatSearchModel(
      id: (json['id'] as num?)?.toInt(),
      cardId: json['cardId'] as String?,
      employeeName: json['employeeName'] as String?,
      jobName: json['jobName'] as String?,
      qrarId: json['qrarId'] as String?,
      datQrar: json['datQrar'] as String?,
    );

Map<String, dynamic> _$EmpHasmiatSearchModelToJson(
        EmpHasmiatSearchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardId': instance.cardId,
      'employeeName': instance.employeeName,
      'jobName': instance.jobName,
      'qrarId': instance.qrarId,
      'datQrar': instance.datQrar,
    };

EmpHasmiatReportModel _$EmpHasmiatReportModelFromJson(
        Map<String, dynamic> json) =>
    EmpHasmiatReportModel(
      id: (json['id'] as num?)?.toInt(),
      employeeName: json['employeeName'] as String?,
      jobName: json['jobName'] as String?,
      fia: json['fia'] as String?,
      qrarId: json['qrarId'] as String?,
      datQrar: json['datQrar'] as String?,
      ghyab: (json['ghyab'] as num?)?.toDouble(),
      tagmee3: (json['tagmee3'] as num?)?.toDouble(),
      gza: (json['gza'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EmpHasmiatReportModelToJson(
        EmpHasmiatReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeName': instance.employeeName,
      'jobName': instance.jobName,
      'fia': instance.fia,
      'qrarId': instance.qrarId,
      'datQrar': instance.datQrar,
      'ghyab': instance.ghyab,
      'tagmee3': instance.tagmee3,
      'gza': instance.gza,
    };
