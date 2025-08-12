import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int? id;
  final String? username;
  final String? password;
  final String? empName;
  final List<UserPermissionModel>? userPermissions;

  UserModel({
    this.id,
    this.username,
    this.password,
    this.empName,
    this.userPermissions,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UserPermissionModel {
  final int? id;
  final String? permission;
  final bool? save;
  final bool? edit;
  final bool? del;

  UserPermissionModel({
    this.id,
    this.permission,
    this.save,
    this.edit,
    this.del,
  });

  factory UserPermissionModel.fromJson(Map<String, dynamic> json) =>
      _$UserPermissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserPermissionModelToJson(this);
}
