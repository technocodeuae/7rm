import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../Core/models/base_models.dart';
import 'entity/auth_entity.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthenticateModel extends BaseModel {
  final String? access_token;
  final bool? status;
  final String? message;
  final String? password_token;

  final UserAuthenticateModel? user;

  AuthenticateModel(
      {this.access_token,
      this.user,
      this.status,
      this.message,
      this.password_token});

  factory AuthenticateModel.fromRawJson(String str) =>
      AuthenticateModel.fromJson(json.decode(str));

  factory AuthenticateModel.fromJson(Map<String, dynamic> json) =>
      _$AuthenticateModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticateModelToJson(this);

  @override
  AuthenticateEntity toEntity() {
    return AuthenticateEntity(
        access_token: access_token, user: user?.toEntity());
  }
}

///////
@JsonSerializable()
class UserAuthenticateModel extends BaseModel {
  UserAuthenticateModel({
    this.id,
    this.userName,
    this.email,
    this.firstName,
    this.lastName,
    this.profile,
    this.userImage,
    this.gender,
    this.mobile,
    this.fullMobileNumber,
    this.createdAt,
    this.isMobileVerified,
    this.isActive,
    this.latitude,
    this.longitude,
    this.evaluation,
    this.country,
    this.stable,
    this.specializations,
    this.evaluationsOfUser,
    this.userEvaluations,
  });

  final int? id;

  @JsonKey(name: 'user_name')
  final String? userName;
  final String? email;

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;
  final dynamic profile;

  @JsonKey(name: 'user_image')
  final dynamic userImage;
  final String? gender;
  final String? mobile;

  @JsonKey(name: 'full_mobile_number')
  final dynamic fullMobileNumber;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'is_mobile_verified')
  final int? isMobileVerified;

  @JsonKey(name: 'is_active')
  final int? isActive;
  final String? latitude;
  final String? longitude;
  final int? evaluation;
  final dynamic country;
  final dynamic stable;
  final List<dynamic>? specializations;

  @JsonKey(name: 'evaluations_of_user')
  final List<dynamic>? evaluationsOfUser;

  @JsonKey(name: 'user_evaluations')
  final List<dynamic>? userEvaluations;

  factory UserAuthenticateModel.fromRawJson(String str) =>
      UserAuthenticateModel.fromJson(json.decode(str));

  factory UserAuthenticateModel.fromJson(Map<String, dynamic> json) =>
      _$UserAuthenticateModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserAuthenticateModelToJson(this);

  @override
  UserAuthenticateEntity toEntity() {
    return UserAuthenticateEntity(
      id: id,
      email: email,
      gender: gender,
      firstName: firstName,
      lastName: lastName,
      longitude: longitude,
      latitude: latitude,
      mobile: mobile,
      country: country,
    );
  }
}
