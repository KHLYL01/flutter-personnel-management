// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_kashf_tepy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpKashfTepyModel _$EmpKashfTepyModelFromJson(Map<String, dynamic> json) =>
    EmpKashfTepyModel(
      id: (json['id'] as num?)?.toInt(),
      empId: (json['empId'] as num?)?.toInt(),
      requestDateString: json['requestDateString'] as String?,
      requestDate: json['requestDate'] as String?,
      wehdaType: json['wehdaType'] as String?,
      wehdaName: json['wehdaName'] as String?,
      notes: json['notes'] as String?,
      employeeStatus: json['employeeStatus'] as String?,
      endDateString: json['endDateString'] as String?,
      endDate: json['endDate'] as String?,
      computerName: json['computerName'] as String?,
      computerUser: json['computerUser'] as String?,
      programUser: json['programUser'] as String?,
      inputDate: json['inputDate'] as String?,
    );

Map<String, dynamic> _$EmpKashfTepyModelToJson(EmpKashfTepyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'empId': instance.empId,
      'requestDateString': instance.requestDateString,
      'requestDate': instance.requestDate,
      'wehdaType': instance.wehdaType,
      'wehdaName': instance.wehdaName,
      'notes': instance.notes,
      'employeeStatus': instance.employeeStatus,
      'endDateString': instance.endDateString,
      'endDate': instance.endDate,
      'computerName': instance.computerName,
      'computerUser': instance.computerUser,
      'programUser': instance.programUser,
      'inputDate': instance.inputDate,
    };

EmpKashfTepySearchModel _$EmpKashfTepySearchModelFromJson(
        Map<String, dynamic> json) =>
    EmpKashfTepySearchModel(
      id: (json['id'] as num?)?.toInt(),
      cardId: json['cardId'] as String?,
      employeeName: json['employeeName'] as String?,
      jobName: json['jobName'] as String?,
      requestDate: json['requestDate'] as String?,
      employeeStatus: json['employeeStatus'] as String?,
      medicalUnitName: json['medicalUnitName'] as String?,
    );

Map<String, dynamic> _$EmpKashfTepySearchModelToJson(
        EmpKashfTepySearchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardId': instance.cardId,
      'employeeName': instance.employeeName,
      'jobName': instance.jobName,
      'requestDate': instance.requestDate,
      'employeeStatus': instance.employeeStatus,
      'medicalUnitName': instance.medicalUnitName,
    };

EmpKashfTepyReportModel _$EmpKashfTepyReportModelFromJson(
        Map<String, dynamic> json) =>
    EmpKashfTepyReportModel(
      id: (json['id'] as num?)?.toInt(),
      employeeName: json['employeeName'] as String?,
      jobName: json['jobName'] as String?,
      requestDate: json['requestDate'] as String?,
      medicalUnitType: json['medicalUnitType'] as String?,
      medicalUnitName: json['medicalUnitName'] as String?,
      employeeStatus: json['employeeStatus'] as String?,
      datEnketa3: json['datEnketa3'] as String?,
    );

Map<String, dynamic> _$EmpKashfTepyReportModelToJson(
        EmpKashfTepyReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeName': instance.employeeName,
      'jobName': instance.jobName,
      'requestDate': instance.requestDate,
      'medicalUnitType': instance.medicalUnitType,
      'medicalUnitName': instance.medicalUnitName,
      'employeeStatus': instance.employeeStatus,
      'datEnketa3': instance.datEnketa3,
    };
