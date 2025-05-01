// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_entedab_det_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpEntedabDetModel _$EmpEntedabDetModelFromJson(Map<String, dynamic> json) =>
    EmpEntedabDetModel(
      maxId: (json['maxId'] as num?)?.toInt(),
      entedabId: (json['entedabId'] as num?)?.toInt(),
      empId: (json['empId'] as num?)?.toInt(),
      empName: json['empName'] as String?,
      salary: (json['salary'] as num?)?.toDouble(),
      fia: json['fia'] as String?,
      draga: (json['draga'] as num?)?.toDouble(),
      naqlBadal: (json['naqlBadal'] as num?)?.toDouble(),
      entedabBadal: (json['entedabBadal'] as num?)?.toDouble(),
      prev: (json['prev'] as num?)?.toInt(),
      externalEntedab: (json['externalEntedab'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EmpEntedabDetModelToJson(EmpEntedabDetModel instance) =>
    <String, dynamic>{
      'maxId': instance.maxId,
      'entedabId': instance.entedabId,
      'empId': instance.empId,
      'empName': instance.empName,
      'salary': instance.salary,
      'fia': instance.fia,
      'draga': instance.draga,
      'naqlBadal': instance.naqlBadal,
      'entedabBadal': instance.entedabBadal,
      'prev': instance.prev,
      'externalEntedab': instance.externalEntedab,
    };
