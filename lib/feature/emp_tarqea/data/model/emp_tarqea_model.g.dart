// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_tarqea_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpTarqeaModel _$EmpTarqeaModelFromJson(Map<String, dynamic> json) =>
    EmpTarqeaModel(
      id: (json['id'] as num?)?.toInt(),
      qrarId: json['qrarId'] as String?,
      qrarDate: json['qrarDate'] as String?,
      khetabId: json['khetabId'] as String?,
      khetabDate: json['khetabDate'] as String?,
      mosadakaId: json['mosadakaId'] as String?,
      mosadakaDate: json['mosadakaDate'] as String?,
      mahdarId: json['mahdarId'] as String?,
      mahdarDate: json['mahdarDate'] as String?,
      oldJobId: (json['oldJobId'] as num?)?.toInt(),
      oldFia: json['oldFia'] as String?,
      oldNo: (json['oldNo'] as num?)?.toInt(),
      oldSalary: (json['oldSalary'] as num?)?.toDouble(),
      oldNaqlBadal: (json['oldNaqlBadal'] as num?)?.toDouble(),
      oldJobBadalat: (json['oldJobBadalat'] as num?)?.toDouble(),
      oldPartId: (json['oldPartId'] as num?)?.toInt(),
      oldSymble: json['oldSymble'] as String?,
      newJobId: (json['newJobId'] as num?)?.toInt(),
      newFia: json['newFia'] as String?,
      newNo: (json['newNo'] as num?)?.toInt(),
      newSalary: (json['newSalary'] as num?)?.toDouble(),
      newNaqlBadal: (json['newNaqlBadal'] as num?)?.toDouble(),
      newJobBadalat: (json['newJobBadalat'] as num?)?.toDouble(),
      newPartId: (json['newPartId'] as num?)?.toInt(),
      newSymble: json['newSymble'] as String?,
      percent: (json['percent'] as num?)?.toInt(),
      empId: (json['empId'] as num?)?.toInt(),
      mobasharaDate: json['mobasharaDate'] as String?,
      mobasharaDay: json['mobasharaDay'] as String?,
      mKhetabId: json['mKhetabId'] as String?,
      mKhetabDate: json['mKhetabDate'] as String?,
    );

Map<String, dynamic> _$EmpTarqeaModelToJson(EmpTarqeaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qrarId': instance.qrarId,
      'qrarDate': instance.qrarDate,
      'khetabId': instance.khetabId,
      'khetabDate': instance.khetabDate,
      'mosadakaId': instance.mosadakaId,
      'mosadakaDate': instance.mosadakaDate,
      'mahdarId': instance.mahdarId,
      'mahdarDate': instance.mahdarDate,
      'oldJobId': instance.oldJobId,
      'oldFia': instance.oldFia,
      'oldNo': instance.oldNo,
      'oldSalary': instance.oldSalary,
      'oldNaqlBadal': instance.oldNaqlBadal,
      'oldJobBadalat': instance.oldJobBadalat,
      'oldPartId': instance.oldPartId,
      'oldSymble': instance.oldSymble,
      'newJobId': instance.newJobId,
      'newFia': instance.newFia,
      'newNo': instance.newNo,
      'newSalary': instance.newSalary,
      'newNaqlBadal': instance.newNaqlBadal,
      'newJobBadalat': instance.newJobBadalat,
      'newPartId': instance.newPartId,
      'newSymble': instance.newSymble,
      'percent': instance.percent,
      'empId': instance.empId,
      'mobasharaDate': instance.mobasharaDate,
      'mobasharaDay': instance.mobasharaDay,
      'mKhetabId': instance.mKhetabId,
      'mKhetabDate': instance.mKhetabDate,
    };

EmpTarqeaSearchModel _$EmpTarqeaSearchModelFromJson(
        Map<String, dynamic> json) =>
    EmpTarqeaSearchModel(
      id: (json['id'] as num?)?.toInt(),
      qrarId: json['qrarId'] as String?,
      qrarDate: json['qrarDate'] as String?,
      employeeName: json['employeeName'] as String?,
      oldFia: json['oldFia'] as String?,
      newFia: json['newFia'] as String?,
    );

Map<String, dynamic> _$EmpTarqeaSearchModelToJson(
        EmpTarqeaSearchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qrarId': instance.qrarId,
      'qrarDate': instance.qrarDate,
      'employeeName': instance.employeeName,
      'oldFia': instance.oldFia,
      'newFia': instance.newFia,
    };
