import 'package:json_annotation/json_annotation.dart';

part 'badal_model.g.dart';

@JsonSerializable()
class BadalModel {
  final int? id;
  final int? martaba;
  final int? classA;
  final int? classB;
  final int? classC;
  final int? internal;
  final int? highLiving;

  BadalModel({
    this.id,
    this.martaba,
    this.classA,
    this.classB,
    this.classC,
    this.internal,
    this.highLiving,
  });

  factory BadalModel.fromJson(Map<String, dynamic> json) =>
      _$BadalModelFromJson(json);

  Map<String, dynamic> toJson() => _$BadalModelToJson(this);
}
