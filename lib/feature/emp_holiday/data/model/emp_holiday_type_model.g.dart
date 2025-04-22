// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_holiday_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpHolidayTypeModel _$EmpHolidayTypeModelFromJson(Map<String, dynamic> json) =>
    EmpHolidayTypeModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      isEmpOnly: (json['isEmpOnly'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EmpHolidayTypeModelToJson(
        EmpHolidayTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isEmpOnly': instance.isEmpOnly,
    };
