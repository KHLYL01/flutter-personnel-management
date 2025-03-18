// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nations_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NationsModel _$NationsModelFromJson(Map<String, dynamic> json) => NationsModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$NationsModelToJson(NationsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
