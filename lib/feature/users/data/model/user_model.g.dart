// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      key: json['key'] == null
          ? null
          : KeyModel.fromJson(json['key'] as Map<String, dynamic>),
      name: json['name'] as String?,
      pass: json['pass'] as String?,
      empName: json['empName'] as String?,
      save: (json['save'] as num?)?.toInt(),
      edit: (json['edit'] as num?)?.toInt(),
      del: (json['del'] as num?)?.toInt(),
      mostahaka: (json['mostahaka'] as num?)?.toInt(),
      directBoss: (json['directBoss'] as num?)?.toInt(),
      salahea: (json['salahea'] as num?)?.toInt(),
      empId: (json['empId'] as num?)?.toInt(),
      majless: (json['majless'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'pass': instance.pass,
      'empName': instance.empName,
      'save': instance.save,
      'edit': instance.edit,
      'del': instance.del,
      'mostahaka': instance.mostahaka,
      'directBoss': instance.directBoss,
      'salahea': instance.salahea,
      'empId': instance.empId,
      'majless': instance.majless,
    };

KeyModel _$KeyModelFromJson(Map<String, dynamic> json) => KeyModel(
      id: (json['id'] as num?)?.toInt(),
      menus: json['menus'] as String?,
    );

Map<String, dynamic> _$KeyModelToJson(KeyModel instance) => <String, dynamic>{
      'id': instance.id,
      'menus': instance.menus,
    };

UserDtoModel _$UserDtoModelFromJson(Map<String, dynamic> json) => UserDtoModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      pass: json['pass'] as String?,
      empName: json['empName'] as String?,
    );

Map<String, dynamic> _$UserDtoModelToJson(UserDtoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pass': instance.pass,
      'empName': instance.empName,
    };
