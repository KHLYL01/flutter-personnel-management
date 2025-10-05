// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_services_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpServicesModel _$EmpServicesModelFromJson(Map<String, dynamic> json) =>
    EmpServicesModel(
      id: (json['id'] as num?)?.toInt(),
      empId: (json['empId'] as num?)?.toInt(),
      job: json['job'] as String?,
      martaba: json['martaba'] as String?,
      mnum: json['mnum'] as String?,
      salary: (json['salary'] as num?)?.toDouble(),
      place: json['place'] as String?,
      datB: json['datB'] as String?,
      datE: json['datE'] as String?,
      reasons: json['reasons'] as String?,
      amrNo: json['amrNo'] as String?,
      datAmr: json['datAmr'] as String?,
      nots: json['nots'] as String?,
    );

Map<String, dynamic> _$EmpServicesModelToJson(EmpServicesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'empId': instance.empId,
      'job': instance.job,
      'martaba': instance.martaba,
      'mnum': instance.mnum,
      'salary': instance.salary,
      'place': instance.place,
      'datB': instance.datB,
      'datE': instance.datE,
      'reasons': instance.reasons,
      'amrNo': instance.amrNo,
      'datAmr': instance.datAmr,
      'nots': instance.nots,
    };
