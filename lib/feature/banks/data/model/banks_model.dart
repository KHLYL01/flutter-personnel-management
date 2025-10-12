import 'package:json_annotation/json_annotation.dart';

part 'banks_model.g.dart';

@JsonSerializable()
class BanksModel {
  final String? id;
  final String? name;

  BanksModel({this.id, this.name});

  factory BanksModel.fromJson(Map<String, dynamic> json) =>
      _$BanksModelFromJson(json);

  Map<String, dynamic> toJson() => _$BanksModelToJson(this);

  List<dynamic> get toList => [id, name];
}
