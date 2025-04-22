// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../emp_end/data/model/emp_end_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpEndModel _$EmpEndModelFromJson(Map<String, dynamic> json) => EmpEndModel(
      id: (json['id'] as num?)?.toInt(),
      qrarId: json['qrarId'] as String?,
      qrarDate: json['qrarDate'] as String?,
      empId: (json['empId'] as num?)?.toInt(),
      endDate: json['endDate'] as String?,
      days: json['days'] as String?,
      reward: (json['reward'] as num?)?.toInt(),
      taqa7d: (json['taqa7d'] as num?)?.toInt(),
      birthDate: json['birthDate'] as String?,
      age: (json['age'] as num?)?.toInt(),
      reward1: (json['reward1'] as num?)?.toInt(),
      computerName: json['computerName'] as String?,
      computerUser: json['computerUser'] as String?,
      programUser: json['programUser'] as String?,
      inputDate: json['inputDate'] as String?,
    );

Map<String, dynamic> _$EmpEndModelToJson(EmpEndModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qrarId': instance.qrarId,
      'qrarDate': instance.qrarDate,
      'empId': instance.empId,
      'endDate': instance.endDate,
      'days': instance.days,
      'reward': instance.reward,
      'taqa7d': instance.taqa7d,
      'birthDate': instance.birthDate,
      'age': instance.age,
      'reward1': instance.reward1,
      'computerName': instance.computerName,
      'computerUser': instance.computerUser,
      'programUser': instance.programUser,
      'inputDate': instance.inputDate,
    };

EmpEndSearchModel _$EmpEndSearchModelFromJson(Map<String, dynamic> json) =>
    EmpEndSearchModel(
      id: (json['id'] as num?)?.toInt(),
      qrarId: json['qrarId'] as String?,
      qrarDate: json['qrarDate'] as String?,
      employeeName: json['employeeName'] as String?,
      terminationDate: json['terminationDate'] as String?,
    );

Map<String, dynamic> _$EmpEndSearchModelToJson(EmpEndSearchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qrarId': instance.qrarId,
      'qrarDate': instance.qrarDate,
      'employeeName': instance.employeeName,
      'terminationDate': instance.terminationDate,
    };
