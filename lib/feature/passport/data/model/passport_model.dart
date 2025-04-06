import 'package:json_annotation/json_annotation.dart';

part 'passport_model.g.dart';

@JsonSerializable()
class PassportModel {
  final int? id;
  final String? name;
  final int? nationalId;
  final String? documentNumber;
  final String? exportFrom;
  final String? witness;
  final String? owner;
  final String? date;

  PassportModel({
    this.id,
    this.name,
    this.nationalId,
    this.documentNumber,
    this.exportFrom,
    this.witness,
    this.owner,
    this.date,
  });

  factory PassportModel.fromJson(Map<String, dynamic> json) =>
      _$PassportModelFromJson(json);

  Map<String, dynamic> toJson() => _$PassportModelToJson(this);
}

@JsonSerializable()
class PassportSearchModel {
  final int? id; // رقم الإقرار
  final String? declarationDate; // تاريخ الإقرار
  final String? name; // الاسم
  final String? nationality; // الجنسية
  final String? passportNumber; // رقم الجواز
  final String? issuedBy; // صادر من

  PassportSearchModel({
    this.id,
    this.declarationDate,
    this.name,
    this.nationality,
    this.passportNumber,
    this.issuedBy,
  });

  factory PassportSearchModel.fromJson(Map<String, dynamic> json) =>
      _$PassportSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$PassportSearchModelToJson(this);
}
