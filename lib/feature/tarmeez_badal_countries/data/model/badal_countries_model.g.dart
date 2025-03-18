// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badal_countries_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadalCountriesModel _$BadalCountriesModelFromJson(Map<String, dynamic> json) =>
    BadalCountriesModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      countryClass: json['countryClass'] as String?,
    );

Map<String, dynamic> _$BadalCountriesModelToJson(
        BadalCountriesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'countryClass': instance.countryClass,
    };
