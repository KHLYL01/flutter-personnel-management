// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_takleef_det_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpTakleefDetModel _$EmpTakleefDetModelFromJson(Map<String, dynamic> json) =>
    EmpTakleefDetModel(
      maxId: (json['maxId'] as num?)?.toInt(),
      takleefId: (json['takleefId'] as num?)?.toInt(),
      empId: (json['empId'] as num?)?.toInt(),
      empWork: json['empWork'] as String?,
      period: (json['period'] as num?)?.toDouble(),
      datBegin: json['datBegin'] as String?,
      datEnd: json['datEnd'] as String?,
      empName: json['empName'] as String?,
      salary: (json['salary'] as num?)?.toDouble(),
      naqlBadal: (json['naqlBadal'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EmpTakleefDetModelToJson(EmpTakleefDetModel instance) =>
    <String, dynamic>{
      'maxId': instance.maxId,
      'takleefId': instance.takleefId,
      'empId': instance.empId,
      'empWork': instance.empWork,
      'period': instance.period,
      'datBegin': instance.datBegin,
      'datEnd': instance.datEnd,
      'empName': instance.empName,
      'salary': instance.salary,
      'naqlBadal': instance.naqlBadal,
    };
