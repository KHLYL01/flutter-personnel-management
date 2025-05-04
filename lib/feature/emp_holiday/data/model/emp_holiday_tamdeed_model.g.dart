// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_holiday_tamdeed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpHolidayTamdeedModel _$EmpHolidayTamdeedModelFromJson(
        Map<String, dynamic> json) =>
    EmpHolidayTamdeedModel(
      id: (json['id'] as num?)?.toInt(),
      holidaysId: (json['holidaysId'] as num?)?.toInt(),
      tamdeedPeriod: (json['tamdeedPeriod'] as num?)?.toInt(),
      tamdeedBegin: json['tamdeedBegin'] as String?,
      tamdeedEnd: json['tamdeedEnd'] as String?,
      tepyNo: json['tepyNo'] as String?,
      tepyDate: json['tepyDate'] as String?,
      hospital: json['hospital'] as String?,
      holidayType: (json['holidayType'] as num?)?.toInt(),
      tamdeedBeginGo: json['tamdeedBeginGo'] as String?,
      tamdeedEndGo: json['tamdeedEndGo'] as String?,
      tepyDateGo: json['tepyDateGo'] as String?,
    );

Map<String, dynamic> _$EmpHolidayTamdeedModelToJson(
        EmpHolidayTamdeedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'holidaysId': instance.holidaysId,
      'tamdeedPeriod': instance.tamdeedPeriod,
      'tamdeedBegin': instance.tamdeedBegin,
      'tamdeedEnd': instance.tamdeedEnd,
      'tepyNo': instance.tepyNo,
      'tepyDate': instance.tepyDate,
      'hospital': instance.hospital,
      'holidayType': instance.holidayType,
      'tamdeedBeginGo': instance.tamdeedBeginGo,
      'tamdeedEndGo': instance.tamdeedEndGo,
      'tepyDateGo': instance.tepyDateGo,
    };
