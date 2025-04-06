import 'package:json_annotation/json_annotation.dart';

part 'emp_hasmiat_model.g.dart';

@JsonSerializable()
class EmpHasmiatModel {
  final int? id;
  final String? qrarId;
  final String? datQrar;
  final String? datQrarGo;
  final int? empId;
  final String? mrtaba;
  final double? draga;
  final double? salary;
  final double? naqlBadal;
  final double? ghyab;
  final double? tagmee3;
  final double? gza;
  final String? datBegin;
  final String? datBeginGo;
  final String? datEnd;
  final String? datEndGo;
  final String? byan;
  final String? computerName;
  final String? computerUser;
  final String? programUser;
  final String? inDate;
  final String? month1;
  final String? month2;
  final String? year1;
  final String? year2;
  final String? dependOn;
  final String? footer;
  final String? hasmType;

  EmpHasmiatModel({
    this.id,
    this.qrarId,
    this.datQrar,
    this.datQrarGo,
    this.empId,
    this.mrtaba,
    this.draga,
    this.salary,
    this.naqlBadal,
    this.ghyab,
    this.tagmee3,
    this.gza,
    this.datBegin,
    this.datBeginGo,
    this.datEnd,
    this.datEndGo,
    this.byan,
    this.computerName,
    this.computerUser,
    this.programUser,
    this.inDate,
    this.month1,
    this.month2,
    this.year1,
    this.year2,
    this.dependOn,
    this.footer,
    this.hasmType,
  });

  factory EmpHasmiatModel.fromJson(Map<String, dynamic> json) =>
      _$EmpHasmiatModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpHasmiatModelToJson(this);
}

@JsonSerializable()
class EmpHasmiatSearchModel {
  final int? id; // Emp_Hasmiat.ID
  final String? cardId; // رقم السجل المدني
  final String? employeeName; // الاسم
  final String? jobName; // مسمى الوظيفة
  final String? qrarId; // رقم القرار
  final String? datQrar; // تاريخ القرار

  EmpHasmiatSearchModel({
    this.id,
    this.cardId,
    this.employeeName,
    this.jobName,
    this.qrarId,
    this.datQrar,
  });

  factory EmpHasmiatSearchModel.fromJson(Map<String, dynamic> json) =>
      _$EmpHasmiatSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpHasmiatSearchModelToJson(this);
}
