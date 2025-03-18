// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobsModel _$JobsModelFromJson(Map<String, dynamic> json) => JobsModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$JobsModelToJson(JobsModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
