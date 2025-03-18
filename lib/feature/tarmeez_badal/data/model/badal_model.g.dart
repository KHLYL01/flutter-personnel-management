// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadalModel _$BadalModelFromJson(Map<String, dynamic> json) => BadalModel(
      id: (json['id'] as num?)?.toInt(),
      martaba: (json['martaba'] as num?)?.toInt(),
      classA: (json['classA'] as num?)?.toInt(),
      classB: (json['classB'] as num?)?.toInt(),
      classC: (json['classC'] as num?)?.toInt(),
      internal: (json['internal'] as num?)?.toInt(),
      highLiving: (json['highLiving'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BadalModelToJson(BadalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'martaba': instance.martaba,
      'classA': instance.classA,
      'classB': instance.classB,
      'classC': instance.classC,
      'internal': instance.internal,
      'highLiving': instance.highLiving,
    };
