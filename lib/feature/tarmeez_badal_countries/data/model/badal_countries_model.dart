import 'package:json_annotation/json_annotation.dart';

part 'badal_countries_model.g.dart';

@JsonSerializable()
class BadalCountriesModel {
  final int? id;
  final String? name;
  final String? countryClass;

  BadalCountriesModel({this.id, this.name, this.countryClass});

  factory BadalCountriesModel.fromJson(Map<String, dynamic> json) =>
      _$BadalCountriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$BadalCountriesModelToJson(this);
}
