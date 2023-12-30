// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticateModel _$AuthenticateModelFromJson(Map<String, dynamic> json) =>
    AuthenticateModel(
      status: json['status'] as bool?,
      message: json['message'] as String,
      access_token: json['accessToken'] as String?,
      password_token: json['password_token'] as String?,
      user: json['user'] == null
          ? null
          : UserAuthenticateModel.fromJson(
              json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthenticateModelToJson(AuthenticateModel instance) =>
    <String, dynamic>{
      'accessToken': instance.access_token,
      'user': instance.user,
    };
UserAuthenticateModel _$UserAuthenticateModelFromJson(
        Map<String, dynamic> json) =>
    UserAuthenticateModel(
      id: json["id"],
      userName: json["user_name"],
      email: json["email"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      profile: json["profile"],
      userImage: json["user_image"],
      gender: json["gender"],
      mobile: json["mobile"],
      fullMobileNumber: json["full_mobile_number"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      isMobileVerified: json["is_mobile_verified"],
      isActive: json["is_active"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      evaluation: json["evaluation"],
      country: json["country"],
      stable: json["stable"],
      specializations: json["specializations"] == null
          ? []
          : List<dynamic>.from(json["specializations"]!.map((x) => x)),
      evaluationsOfUser: json["evaluations_of_user"] == null
          ? []
          : List<dynamic>.from(json["evaluations_of_user"]!.map((x) => x)),
      userEvaluations: json["user_evaluations"] == null
          ? []
          : List<dynamic>.from(json["user_evaluations"]!.map((x) => x)),
    );

Map<String, dynamic> _$UserAuthenticateModelToJson(
        UserAuthenticateModel instance) =>
    <String, dynamic>{
      "id": instance.id,
      "user_name": instance.userName,
      "email": instance.email,
      "first_name": instance.firstName,
      "last_name": instance.lastName,
      "profile": instance.profile,
      "user_image": instance.userImage,
      "gender": instance.gender,
      "mobile": instance.mobile,
      "full_mobile_number": instance.fullMobileNumber,
      "created_at": instance.createdAt?.toIso8601String(),
      "is_mobile_verified": instance.isMobileVerified,
      "is_active": instance.isActive,
      "latitude": instance.latitude,
      "longitude": instance.longitude,
      "evaluation": instance.evaluation,
      "country": instance.country,
      "stable": instance.stable,
      "specializations": instance.specializations?.map((x) => x).toList(),
      "evaluations_of_user": instance.evaluationsOfUser?.map((x) => x).toList(),
      "user_evaluations": instance.userEvaluations?.map((x) => x).toList(),
    };
//////////////
