// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_degrees_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpDegreesModel _$EmpDegreesModelFromJson(Map<String, dynamic> json) =>
    EmpDegreesModel(
      id: (json['id'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toDouble(),
      martaba: (json['martaba'] as num?)?.toDouble(),
      draga: (json['draga'] as num?)?.toDouble(),
      salary: (json['salary'] as num?)?.toDouble(),
      naqlBadal: (json['naqlBadal'] as num?)?.toDouble(),
      elawa: (json['elawa'] as num?)?.toDouble(),
      inEntedabBadal: (json['inEntedabBadal'] as num?)?.toDouble(),
      outEntedabadal: (json['outEntedabadal'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EmpDegreesModelToJson(EmpDegreesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'martaba': instance.martaba,
      'draga': instance.draga,
      'salary': instance.salary,
      'naqlBadal': instance.naqlBadal,
      'elawa': instance.elawa,
      'inEntedabBadal': instance.inEntedabBadal,
      'outEntedabadal': instance.outEntedabadal,
    };
