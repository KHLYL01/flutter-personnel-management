// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartsModel _$PartsModelFromJson(Map<String, dynamic> json) => PartsModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PartsModelToJson(PartsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
