// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignatureModel _$SignatureModelFromJson(Map<String, dynamic> json) =>
    SignatureModel(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      empName: json['empName'] as String?,
      content: json['content'] as String?,
      image: const Uint8ListConverter().fromJson(json['image']),
      imageUrl: json['imageUrl'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$SignatureModelToJson(SignatureModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'empName': instance.empName,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'password': instance.password,
      'image': const Uint8ListConverter().toJson(instance.image),
    };
