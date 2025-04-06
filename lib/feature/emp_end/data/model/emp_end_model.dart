import 'package:json_annotation/json_annotation.dart';

part 'emp_end_model.g.dart';

@JsonSerializable()
class EmpEndModel {
  final int? id;
  final String? qrarId;
  final String? qrarDate;
  final int? empId;
  final String? endDate;
  final String? days;
  final int? reward;
  final int? taqa7d;
  final String? birthDate;
  final int? age;
  final int? reward1;

  final String? computerName;
  final String? computerUser;
  final String? programUser;
  final String? inputDate;

  EmpEndModel({
    this.id,
    this.qrarId,
    this.qrarDate,
    this.empId,
    this.endDate,
    this.days,
    this.reward,
    this.taqa7d,
    this.birthDate,
    this.age,
    this.reward1,
    this.computerName,
    this.computerUser,
    this.programUser,
    this.inputDate,
  });

  factory EmpEndModel.fromJson(Map<String, dynamic> json) =>
      _$EmpEndModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpEndModelToJson(this);
}

@JsonSerializable()
class EmpEndSearchModel {
  final int? id; // EMP_ENDEMP.ID
  final String? qrarId; // رقم القرار
  final String? qrarDate; // تاريخ القرار
  final String? employeeName; // اسم الموظف
  final String? terminationDate; // تاريخ الإنهاء

  EmpEndSearchModel({
    this.id,
    this.qrarId,
    this.qrarDate,
    this.employeeName,
    this.terminationDate,
  });

  factory EmpEndSearchModel.fromJson(Map<String, dynamic> json) =>
      _$EmpEndSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpEndSearchModelToJson(this);
}
