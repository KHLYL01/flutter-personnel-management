// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String?,
      password: json['password'] as String?,
      empName: json['empName'] as String?,
      userPermissions: (json['userPermissions'] as List<dynamic>?)
          ?.map((e) => UserPermissionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'empName': instance.empName,
      'userPermissions': instance.userPermissions,
    };

UserPermissionModel _$UserPermissionModelFromJson(Map<String, dynamic> json) =>
    UserPermissionModel(
      id: (json['id'] as num?)?.toInt(),
      permission: json['permission'] as String?,
      save: json['save'] as bool?,
      edit: json['edit'] as bool?,
      del: json['del'] as bool?,
    );

Map<String, dynamic> _$UserPermissionModelToJson(
        UserPermissionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'permission': instance.permission,
      'save': instance.save,
      'edit': instance.edit,
      'del': instance.del,
    };
