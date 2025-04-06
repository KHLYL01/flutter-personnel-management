// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_taeen_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpTaeenModel _$EmpTaeenModelFromJson(Map<String, dynamic> json) =>
    EmpTaeenModel(
      id: (json['id'] as num?)?.toInt(),
      qrarId: json['qrarId'] as String?,
      qrarDate: json['qrarDate'] as String?,
      empId: (json['empId'] as num?)?.toInt(),
      birthDate: json['birthDate'] as String?,
      state: (json['state'] as num?)?.toInt(),
      gender: (json['gender'] as num?)?.toInt(),
      socialNumber: json['socialNumber'] as String?,
      khetabId: json['khetabId'] as String?,
      khetabDate: json['khetabDate'] as String?,
      khetabName: json['khetabName'] as String?,
      mKhetabDate: json['mKhetabDate'] as String?,
      mDay: json['mDay'] as String?,
    );

Map<String, dynamic> _$EmpTaeenModelToJson(EmpTaeenModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qrarId': instance.qrarId,
      'qrarDate': instance.qrarDate,
      'empId': instance.empId,
      'birthDate': instance.birthDate,
      'state': instance.state,
      'gender': instance.gender,
      'socialNumber': instance.socialNumber,
      'khetabId': instance.khetabId,
      'khetabDate': instance.khetabDate,
      'khetabName': instance.khetabName,
      'mKhetabDate': instance.mKhetabDate,
      'mDay': instance.mDay,
    };

EmpTaeenSearchModel _$EmpTaeenSearchModelFromJson(Map<String, dynamic> json) =>
    EmpTaeenSearchModel(
      id: (json['id'] as num?)?.toInt(),
      qrarId: json['qrarId'] as String?,
      qrarDate: json['qrarDate'] as String?,
      employeeName: json['employeeName'] as String?,
      socialInsuranceNo: json['socialInsuranceNo'] as String?,
      directDate: json['directDate'] as String?,
    );

Map<String, dynamic> _$EmpTaeenSearchModelToJson(
        EmpTaeenSearchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qrarId': instance.qrarId,
      'qrarDate': instance.qrarDate,
      'employeeName': instance.employeeName,
      'socialInsuranceNo': instance.socialInsuranceNo,
      'directDate': instance.directDate,
    };
