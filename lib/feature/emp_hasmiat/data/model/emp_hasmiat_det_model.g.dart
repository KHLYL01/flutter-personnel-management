// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_hasmiat_det_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpHasmiatDetModel _$EmpHasmiatDetModelFromJson(Map<String, dynamic> json) =>
    EmpHasmiatDetModel(
      maxId: (json['maxId'] as num?)?.toInt(),
      hasmId: (json['hasmId'] as num?)?.toInt(),
      empId: (json['empId'] as num?)?.toInt(),
      details: json['details'] as String?,
      mosta7qTotal: (json['mosta7qTotal'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      employeeName: json['employeeName'] as String?,
      salary: (json['salary'] as num?)?.toDouble(),
      naqlBadal: (json['naqlBadal'] as num?)?.toDouble(),
      ghyab: (json['ghyab'] as num?)?.toDouble(),
      tagmee3: (json['tagmee3'] as num?)?.toDouble(),
      min: json['min'] as String?,
      gza: (json['gza'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$EmpHasmiatDetModelToJson(EmpHasmiatDetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeName': instance.employeeName,
      'salary': instance.salary,
      'naqlBadal': instance.naqlBadal,
      'ghyab': instance.ghyab,
      'tagmee3': instance.tagmee3,
      'min': instance.min,
      'gza': instance.gza,
      'notes': instance.notes,
      'maxId': instance.maxId,
      'hasmId': instance.hasmId,
      'empId': instance.empId,
      'details': instance.details,
      'mosta7qTotal': instance.mosta7qTotal,
    };
