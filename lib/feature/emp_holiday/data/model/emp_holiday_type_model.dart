import 'package:json_annotation/json_annotation.dart';

part 'emp_holiday_type_model.g.dart';

@JsonSerializable()
class EmpHolidayTypeModel {
  final int? id;
  final String? name;
  final int? isEmpOnly;

  EmpHolidayTypeModel({this.id, this.name, this.isEmpOnly});

  factory EmpHolidayTypeModel.fromJson(Map<String, dynamic> json) =>
      _$EmpHolidayTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpHolidayTypeModelToJson(this);
}
