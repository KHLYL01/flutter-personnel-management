import 'package:json_annotation/json_annotation.dart';

part 'bladia_info_model.g.dart';

@JsonSerializable()
class BladiaInfoModel {
  final Bladia? bladiaInfo;
  final EmpPartInfo? empPartInfo;

  BladiaInfoModel({this.bladiaInfo, this.empPartInfo});

  factory BladiaInfoModel.fromJson(Map<String, dynamic> json) =>
      _$BladiaInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$BladiaInfoModelToJson(this);
}

@JsonSerializable()
class Bladia {
  final int? id;
  final String? nameAr;
  final String? boss;
  final String? bossAssistant;
  final String? amana;
  // final byte[]? logo;
  final String? ipan;
  final String? datBegin;
  final String? datEnd;

  Bladia({
    this.id,
    this.nameAr,
    this.boss,
    this.bossAssistant,
    this.amana,
    this.ipan,
    this.datBegin,
    this.datEnd,
  });

  factory Bladia.fromJson(Map<String, dynamic> json) => _$BladiaFromJson(json);

  Map<String, dynamic> toJson() => _$BladiaToJson(this);
}

@JsonSerializable()
class EmpPartInfo {
  final int? id;
  final String? partBoss;
  final String? part2Boss;
  final String? maliaBoss;
  final String? emp;
  final String? empHelp;
  final int? ma3esha;
  final String? edariaBoss;
  final String? workStationBoss;

  EmpPartInfo({
    this.id,
    this.partBoss,
    this.part2Boss,
    this.maliaBoss,
    this.emp,
    this.empHelp,
    this.ma3esha,
    this.edariaBoss,
    this.workStationBoss,
  });

  factory EmpPartInfo.fromJson(Map<String, dynamic> json) =>
      _$EmpPartInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EmpPartInfoToJson(this);
}
