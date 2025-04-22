// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_eqrar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpEqrarModel _$EmpEqrarModelFromJson(Map<String, dynamic> json) =>
    EmpEqrarModel(
      id: (json['id'] as num?)?.toInt(),
      letterNumber: (json['letterNumber'] as num?)?.toInt(),
      letterName: json['letterName'] as String?,
      decisionName: json['decisionName'] as String?,
      decisionPlace: json['decisionPlace'] as String?,
      decisionDate: json['decisionDate'] as String?,
      letterDate: json['letterDate'] as String?,
      computerName: json['computerName'] as String?,
      computerUser: json['computerUser'] as String?,
      programUser: json['programUser'] as String?,
      inputDate: json['inputDate'] as String?,
    );

Map<String, dynamic> _$EmpEqrarModelToJson(EmpEqrarModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'letterNumber': instance.letterNumber,
      'letterName': instance.letterName,
      'decisionName': instance.decisionName,
      'decisionPlace': instance.decisionPlace,
      'decisionDate': instance.decisionDate,
      'letterDate': instance.letterDate,
      'computerName': instance.computerName,
      'computerUser': instance.computerUser,
      'programUser': instance.programUser,
      'inputDate': instance.inputDate,
    };

EmpEqrarSearchModel _$EmpEqrarSearchModelFromJson(Map<String, dynamic> json) =>
    EmpEqrarSearchModel(
      id: (json['id'] as num?)?.toInt(),
      eqrarName: json['eqrarName'] as String?,
      eqrarDate: json['eqrarDate'] as String?,
      eqrarPlace: json['eqrarPlace'] as String?,
      khetabNumber: (json['khetabNumber'] as num?)?.toInt(),
      khetabName: json['khetabName'] as String?,
      khetabDate: json['khetabDate'] as String?,
    );

Map<String, dynamic> _$EmpEqrarSearchModelToJson(
        EmpEqrarSearchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eqrarName': instance.eqrarName,
      'eqrarDate': instance.eqrarDate,
      'eqrarPlace': instance.eqrarPlace,
      'khetabNumber': instance.khetabNumber,
      'khetabName': instance.khetabName,
      'khetabDate': instance.khetabDate,
    };
