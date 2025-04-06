// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tafweed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TafweedModel _$TafweedModelFromJson(Map<String, dynamic> json) => TafweedModel(
      id: (json['id'] as num?)?.toInt(),
      subject: json['subject'] as String?,
      empId: (json['empId'] as num?)?.toInt(),
      day: json['day'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      note: json['note'] as String?,
      computerName: json['computerName'] as String?,
      computerUser: json['computerUser'] as String?,
      programUser: json['programUser'] as String?,
      inputDate: json['inputDate'] as String?,
    );

Map<String, dynamic> _$TafweedModelToJson(TafweedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'empId': instance.empId,
      'day': instance.day,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'note': instance.note,
      'computerName': instance.computerName,
      'computerUser': instance.computerUser,
      'programUser': instance.programUser,
      'inputDate': instance.inputDate,
    };

TafweedSearchModel _$TafweedSearchModelFromJson(Map<String, dynamic> json) =>
    TafweedSearchModel(
      id: (json['id'] as num?)?.toInt(),
      employeeName: json['employeeName'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      subject: json['subject'] as String?,
    );

Map<String, dynamic> _$TafweedSearchModelToJson(TafweedSearchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeName': instance.employeeName,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'subject': instance.subject,
    };
