import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String id;
  final String email;
  final bool? emailVerified;

  const UserModel({
    required this.id,
    required this.email,
    required this.emailVerified,
  });

  @override
  List<Object?> get props => [id, email, emailVerified];

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
