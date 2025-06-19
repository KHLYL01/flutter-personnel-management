import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final KeyModel? key;
  final String? name;
  final String? pass;
  final String? empName;
  final int? save;
  final int? edit;
  final int? del;
  final int? mostahaka;
  final int? directBoss;
  final int? salahea;
  final int? empId;
  final int? majless;

  UserModel({
    this.key,
    this.name,
    this.pass,
    this.empName,
    this.save,
    this.edit,
    this.del,
    this.mostahaka,
    this.directBoss,
    this.salahea,
    this.empId,
    this.majless,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class KeyModel {
  final int? id;
  final String? menus;

  KeyModel({
    this.id,
    this.menus,
  });

  factory KeyModel.fromJson(Map<String, dynamic> json) =>
      _$KeyModelFromJson(json);

  Map<String, dynamic> toJson() => _$KeyModelToJson(this);
}

@JsonSerializable()
class UserDtoModel {
  final int? id;
  final String? name;
  final String? pass;
  final String? empName;
  UserDtoModel({
    this.id,
    this.name,
    this.pass,
    this.empName,
  });

  factory UserDtoModel.fromJson(Map<String, dynamic> json) =>
      _$UserDtoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoModelToJson(this);
}
