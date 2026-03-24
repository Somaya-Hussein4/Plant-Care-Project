import 'package:json_annotation/json_annotation.dart';

part 'token_model.g.dart';

@JsonSerializable()
class TokenModel {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  TokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$TokenModelToJson(this);
}
