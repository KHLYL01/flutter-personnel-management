import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mosaeer_salary_model.g.dart';

@JsonSerializable()
class MosaeerSalaryModel {
  final int? id;
  final String? empType;
  final String? name;
  final String? cardId;
  final String? jobName;
  final String? fia;
  final double? draga;
  final double? salary;
  final double? mosta7qSalary;
  final double? naqlBadal;
  final double? jobBadalat;
  final double? ma3esha;
  final int? addDays;
  final double? mosta7qTotal;
  final double? taka3ed;
  final double? taka3odM;
  final double? gza;
  final double? bank;
  final double? sandok;
  final double? zeraee;
  final double? hasmTotal;
  final double? safy;
  final String? comments;
  final double? inSalary;
  final double? inNaqlBadal;
  final double? inMosta7qSalary;
  final double? inMosta7qTotal;
  final double? inSafy;
  final double? safyNaqlBadal;
  final double? safyMa3esha;
  final double? inMa3esha;
  final double? maeesha;
  final String? holidays;
  final int? badal1;
  final int? badal2;
  final int? badal3;
  final int? badal4;
  final int? hasm1;
  final int? hasm2;
  final int? isHasm3;
  final double? hasm3;
  final String? ibanNum;

  @JsonKey(includeFromJson: false, includeToJson: false)
  RxBool check = false.obs;

  MosaeerSalaryModel({
    this.id,
    this.empType,
    this.name,
    this.cardId,
    this.jobName,
    this.fia,
    this.draga,
    this.salary,
    this.mosta7qSalary,
    this.naqlBadal,
    this.jobBadalat,
    this.ma3esha,
    this.addDays,
    this.mosta7qTotal,
    this.taka3ed,
    this.taka3odM,
    this.gza,
    this.bank,
    this.sandok,
    this.zeraee,
    this.hasmTotal,
    this.safy,
    this.comments,
    this.inSalary,
    this.inNaqlBadal,
    this.inMosta7qSalary,
    this.inMosta7qTotal,
    this.inSafy,
    this.safyNaqlBadal,
    this.safyMa3esha,
    this.inMa3esha,
    this.maeesha,
    this.holidays,
    this.badal1,
    this.badal2,
    this.badal3,
    this.badal4,
    this.hasm1,
    this.hasm2,
    this.isHasm3,
    this.hasm3,
    this.ibanNum,
  });

  factory MosaeerSalaryModel.fromJson(Map<String, dynamic> json) =>
      _$MosaeerSalaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$MosaeerSalaryModelToJson(this);
}
