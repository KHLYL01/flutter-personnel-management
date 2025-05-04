import 'package:json_annotation/json_annotation.dart';

part 'emp_holiday_tamdeed_model.g.dart';

@JsonSerializable()
class EmpHolidayTamdeedModel {
  final int? id;
  final int? holidaysId;
  final int? tamdeedPeriod;
  final String? tamdeedBegin;
  final String? tamdeedEnd;
  final String? tepyNo;
  final String? tepyDate;
  final String? hospital;
  final int? holidayType;
  final String? tamdeedBeginGo;
  final String? tamdeedEndGo;
  final String? tepyDateGo;

  EmpHolidayTamdeedModel({
    this.id,
    this.holidaysId,
    this.tamdeedPeriod,
    this.tamdeedBegin,
    this.tamdeedEnd,
    this.tepyNo,
    this.tepyDate,
    this.hospital,
    this.holidayType,
    this.tamdeedBeginGo,
    this.tamdeedEndGo,
    this.tepyDateGo,
  });

  factory EmpHolidayTamdeedModel.fromJson(Map<String, dynamic> json) =>
      _$EmpHolidayTamdeedModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpHolidayTamdeedModelToJson(this);
}
