// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_degrees_worker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpDegreesWorkerModel _$EmpDegreesWorkerModelFromJson(
        Map<String, dynamic> json) =>
    EmpDegreesWorkerModel(
      id: (json['id'] as num?)?.toInt(),
      fia: json['fia'] as String?,
      draga: (json['draga'] as num?)?.toDouble(),
      salary: (json['salary'] as num?)?.toDouble(),
      naqlBadal: (json['naqlBadal'] as num?)?.toDouble(),
      elawa: (json['elawa'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EmpDegreesWorkerModelToJson(
        EmpDegreesWorkerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fia': instance.fia,
      'draga': instance.draga,
      'salary': instance.salary,
      'naqlBadal': instance.naqlBadal,
      'elawa': instance.elawa,
    };
