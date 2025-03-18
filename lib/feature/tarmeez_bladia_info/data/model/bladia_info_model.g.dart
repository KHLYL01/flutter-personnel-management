// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bladia_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BladiaInfoModel _$BladiaInfoModelFromJson(Map<String, dynamic> json) =>
    BladiaInfoModel(
      bladiaInfo: json['bladiaInfo'] == null
          ? null
          : Bladia.fromJson(json['bladiaInfo'] as Map<String, dynamic>),
      empPartInfo: json['empPartInfo'] == null
          ? null
          : EmpPartInfo.fromJson(json['empPartInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BladiaInfoModelToJson(BladiaInfoModel instance) =>
    <String, dynamic>{
      'bladiaInfo': instance.bladiaInfo,
      'empPartInfo': instance.empPartInfo,
    };

Bladia _$BladiaFromJson(Map<String, dynamic> json) => Bladia(
      id: (json['id'] as num?)?.toInt(),
      nameAr: json['nameAr'] as String?,
      boss: json['boss'] as String?,
      ipan: json['ipan'] as String?,
      datBegin: json['datBegin'] as String?,
      datEnd: json['datEnd'] as String?,
    );

Map<String, dynamic> _$BladiaToJson(Bladia instance) => <String, dynamic>{
      'id': instance.id,
      'nameAr': instance.nameAr,
      'boss': instance.boss,
      'ipan': instance.ipan,
      'datBegin': instance.datBegin,
      'datEnd': instance.datEnd,
    };

EmpPartInfo _$EmpPartInfoFromJson(Map<String, dynamic> json) => EmpPartInfo(
      id: (json['id'] as num?)?.toInt(),
      partBoss: json['partBoss'] as String?,
      part2Boss: json['part2Boss'] as String?,
      maliaBoss: json['maliaBoss'] as String?,
      emp: json['emp'] as String?,
      empHelp: json['empHelp'] as String?,
      ma3esha: (json['ma3esha'] as num?)?.toInt(),
      workStationBoss: json['workStationBoss'] as String?,
    );

Map<String, dynamic> _$EmpPartInfoToJson(EmpPartInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'partBoss': instance.partBoss,
      'part2Boss': instance.part2Boss,
      'maliaBoss': instance.maliaBoss,
      'emp': instance.emp,
      'empHelp': instance.empHelp,
      'ma3esha': instance.ma3esha,
      'workStationBoss': instance.workStationBoss,
    };
