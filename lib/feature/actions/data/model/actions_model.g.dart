// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionsModel _$ActionsModelFromJson(Map<String, dynamic> json) => ActionsModel(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String?,
      dat: json['dat'] as String?,
      action: json['action'] as String?,
      tim: json['tim'] as String?,
    );

Map<String, dynamic> _$ActionsModelToJson(ActionsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'action': instance.action,
      'dat': instance.dat,
      'tim': instance.tim,
    };
