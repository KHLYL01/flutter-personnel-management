// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passport_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassportModel _$PassportModelFromJson(Map<String, dynamic> json) =>
    PassportModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nationalId: (json['nationalId'] as num?)?.toInt(),
      documentNumber: json['documentNumber'] as String?,
      exportFrom: json['exportFrom'] as String?,
      witness: json['witness'] as String?,
      owner: json['owner'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$PassportModelToJson(PassportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nationalId': instance.nationalId,
      'documentNumber': instance.documentNumber,
      'exportFrom': instance.exportFrom,
      'witness': instance.witness,
      'owner': instance.owner,
      'date': instance.date,
    };

PassportSearchModel _$PassportSearchModelFromJson(Map<String, dynamic> json) =>
    PassportSearchModel(
      id: (json['id'] as num?)?.toInt(),
      declarationDate: json['declarationDate'] as String?,
      name: json['name'] as String?,
      nationality: json['nationality'] as String?,
      passportNumber: json['passportNumber'] as String?,
      issuedBy: json['issuedBy'] as String?,
    );

Map<String, dynamic> _$PassportSearchModelToJson(
        PassportSearchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'declarationDate': instance.declarationDate,
      'name': instance.name,
      'nationality': instance.nationality,
      'passportNumber': instance.passportNumber,
      'issuedBy': instance.issuedBy,
    };
