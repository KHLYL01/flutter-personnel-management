import 'dart:convert';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

part 'signature_model.g.dart';

@JsonSerializable()
class SignatureModel {
  final int? id;
  final int? userId;
  final String? empName;
  final String? content;
  final String? imageUrl;
  final String? password;

  @Uint8ListConverter()
  final Uint8List? image;

  SignatureModel(
      {this.id,
      this.userId,
      this.empName,
      this.content,
      this.image,
      this.imageUrl,
      this.password});

  factory SignatureModel.fromJson(Map<String, dynamic> json) =>
      _$SignatureModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignatureModelToJson(this);
}

/// لتحويل Base64 إلى Uint8List والعكس
class Uint8ListConverter implements JsonConverter<Uint8List?, dynamic> {
  const Uint8ListConverter();

  @override
  Uint8List? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return base64Decode(json);
    return Uint8List.fromList(List<int>.from(json));
  }

  @override
  dynamic toJson(Uint8List? object) {
    if (object == null) return null;
    return base64Encode(object);
  }
}
