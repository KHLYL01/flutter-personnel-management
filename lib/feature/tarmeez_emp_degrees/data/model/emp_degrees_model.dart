import 'package:json_annotation/json_annotation.dart';

part 'emp_degrees_model.g.dart';

@JsonSerializable()
class EmpDegreesModel {
  final int? id;
  final double? type;
  final double? martaba;
  final double? draga;
  final double? salary;
  final double? naqlBadal;
  final double? elawa;
  final double? inEntedabBadal;
  final double? outEntedabadal;

  EmpDegreesModel({
    this.id,
    this.type,
    this.martaba,
    this.draga,
    this.salary,
    this.naqlBadal,
    this.elawa,
    this.inEntedabBadal,
    this.outEntedabadal,
  });

  factory EmpDegreesModel.fromJson(Map<String, dynamic> json) =>
      _$EmpDegreesModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpDegreesModelToJson(this);
}
