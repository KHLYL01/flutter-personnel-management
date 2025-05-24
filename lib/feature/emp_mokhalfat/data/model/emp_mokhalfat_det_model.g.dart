// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_mokhalfat_det_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpMokhalfatDetModel _$EmpMokhalfatDetModelFromJson(
        Map<String, dynamic> json) =>
    EmpMokhalfatDetModel(
      id: (json['id'] as num?)?.toInt(),
      empName: json['empName'] as String?,
      salary: (json['salary'] as num?)?.toDouble(),
      naqlBadal: (json['naqlBadal'] as num?)?.toDouble(),
      fia: json['fia'] as String?,
      draga: (json['draga'] as num?)?.toDouble(),
      maxId: (json['maxId'] as num?)?.toInt(),
      empId: (json['empId'] as num?)?.toInt(),
      mokhalfaId: (json['mokhalfaId'] as num?)?.toInt(),
      gza: (json['gza'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EmpMokhalfatDetModelToJson(
        EmpMokhalfatDetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'empName': instance.empName,
      'salary': instance.salary,
      'naqlBadal': instance.naqlBadal,
      'fia': instance.fia,
      'draga': instance.draga,
      'maxId': instance.maxId,
      'empId': instance.empId,
      'mokhalfaId': instance.mokhalfaId,
      'gza': instance.gza,
    };
