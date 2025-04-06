import 'package:json_annotation/json_annotation.dart';

part 'emp_tarqea_model.g.dart';

@JsonSerializable()
class EmpTarqeaModel {
  final int? id;
  final String? qrarId;
  final String? qrarDate;
  final String? khetabId;
  final String? khetabDate;
  final String? mosadakaId;
  final String? mosadakaDate;
  final String? mahdarId;
  final String? mahdarDate;
  final int? oldJobId;
  final String? oldFia;
  final int? oldNo;
  final double? oldSalary;
  final double? oldNaqlBadal;
  final double? oldJobBadalat;
  final int? oldPartId;
  final String? oldSymble;
  final int? newJobId;
  final String? newFia;
  final int? newNo;
  final double? newSalary;
  final double? newNaqlBadal;
  final double? newJobBadalat;
  final int? newPartId;
  final String? newSymble;
  final int? percent;
  final int? empId;
  final String? mobasharaDate;
  final String? mobasharaDay;
  final String? mKhetabId;
  final String? mKhetabDate;

  EmpTarqeaModel({
    this.id,
    this.qrarId,
    this.qrarDate,
    this.khetabId,
    this.khetabDate,
    this.mosadakaId,
    this.mosadakaDate,
    this.mahdarId,
    this.mahdarDate,
    this.oldJobId,
    this.oldFia,
    this.oldNo,
    this.oldSalary,
    this.oldNaqlBadal,
    this.oldJobBadalat,
    this.oldPartId,
    this.oldSymble,
    this.newJobId,
    this.newFia,
    this.newNo,
    this.newSalary,
    this.newNaqlBadal,
    this.newJobBadalat,
    this.newPartId,
    this.newSymble,
    this.percent,
    this.empId,
    this.mobasharaDate,
    this.mobasharaDay,
    this.mKhetabId,
    this.mKhetabDate,
  });

  factory EmpTarqeaModel.fromJson(Map<String, dynamic> json) =>
      _$EmpTarqeaModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpTarqeaModelToJson(this);
}

@JsonSerializable()
class EmpTarqeaSearchModel {
  final int? id; // EMP_TARQEA.ID
  final String? qrarId; // رقم قرار الترقية
  final String? qrarDate; // تاريخ القرار
  final String? employeeName; // اسم الموظف
  final String? oldFia; // المرتبة القديمة
  final String? newFia; // المرتبة الجديدة

  EmpTarqeaSearchModel({
    this.id,
    this.qrarId,
    this.qrarDate,
    this.employeeName,
    this.oldFia,
    this.newFia,
  });

  factory EmpTarqeaSearchModel.fromJson(Map<String, dynamic> json) =>
      _$EmpTarqeaSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpTarqeaSearchModelToJson(this);
}
