// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_dowra_det_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpDowraDetModel _$EmpDowraDetModelFromJson(Map<String, dynamic> json) =>
    EmpDowraDetModel(
      maxId: (json['maxId'] as num?)?.toInt(),
      empId: (json['empId'] as num?)?.toInt(),
      dowraId: (json['dowraId'] as num?)?.toInt(),
      empName: json['empName'] as String?,
      salary: (json['salary'] as num?)?.toDouble(),
      draga: (json['draga'] as num?)?.toDouble(),
      fia: json['fia'] as String?,
      naqlBadal: (json['naqlBadal'] as num?)?.toDouble(),
      mokafaa: (json['mokafaa'] as num?)?.toInt(),
      badalEntidab: (json['badalEntidab'] as num?)?.toInt(),
      badalTransfare: (json['badalTransfare'] as num?)?.toInt(),
      ticketCost: (json['ticketCost'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EmpDowraDetModelToJson(EmpDowraDetModel instance) =>
    <String, dynamic>{
      'maxId': instance.maxId,
      'empId': instance.empId,
      'dowraId': instance.dowraId,
      'empName': instance.empName,
      'salary': instance.salary,
      'draga': instance.draga,
      'fia': instance.fia,
      'naqlBadal': instance.naqlBadal,
      'mokafaa': instance.mokafaa,
      'badalEntidab': instance.badalEntidab,
      'badalTransfare': instance.badalTransfare,
      'ticketCost': instance.ticketCost,
      'total': instance.total,
    };
