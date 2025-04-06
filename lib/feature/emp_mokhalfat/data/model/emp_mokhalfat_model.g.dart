// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_mokhalfat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpMokhalfatModel _$EmpMokhalfatModelFromJson(Map<String, dynamic> json) =>
    EmpMokhalfatModel(
      id: (json['id'] as num?)?.toInt(),
      mokhalfaType: json['mokhalfaType'] as String?,
      startDateString: json['startDateString'] as String?,
      startDate: json['startDate'] as String?,
      endDateString: json['endDateString'] as String?,
      endDate: json['endDate'] as String?,
      description: json['description'] as String?,
      computerName: json['computerName'] as String?,
      computerUser: json['computerUser'] as String?,
      programUser: json['programUser'] as String?,
      inputDate: json['inputDate'] as String?,
      requestDateString: json['requestDateString'] as String?,
      requestDate: json['requestDate'] as String?,
    );

Map<String, dynamic> _$EmpMokhalfatModelToJson(EmpMokhalfatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mokhalfaType': instance.mokhalfaType,
      'startDateString': instance.startDateString,
      'startDate': instance.startDate,
      'endDateString': instance.endDateString,
      'endDate': instance.endDate,
      'description': instance.description,
      'computerName': instance.computerName,
      'computerUser': instance.computerUser,
      'programUser': instance.programUser,
      'inputDate': instance.inputDate,
      'requestDateString': instance.requestDateString,
      'requestDate': instance.requestDate,
    };

EmpMokhalfatSearchModel _$EmpMokhalfatSearchModelFromJson(
        Map<String, dynamic> json) =>
    EmpMokhalfatSearchModel(
      id: (json['id'] as num?)?.toInt(),
      cardId: json['cardId'] as String?,
      employeeName: json['employeeName'] as String?,
      jobName: json['jobName'] as String?,
      periodFrom: json['periodFrom'] as String?,
      periodTo: json['periodTo'] as String?,
      mokhalfaType: json['mokhalfaType'] as String?,
    );

Map<String, dynamic> _$EmpMokhalfatSearchModelToJson(
        EmpMokhalfatSearchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardId': instance.cardId,
      'employeeName': instance.employeeName,
      'jobName': instance.jobName,
      'periodFrom': instance.periodFrom,
      'periodTo': instance.periodTo,
      'mokhalfaType': instance.mokhalfaType,
    };
