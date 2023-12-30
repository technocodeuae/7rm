import '../../../../core/models/base_entity.dart';

class AuthenticateEntity extends BaseEntity {
  final String? access_token;
  final String? token_type;
  final String? is_signup;

  final UserAuthenticateEntity? user;

  AuthenticateEntity({
    this.access_token,
    this.token_type,
    this.is_signup,
    this.user,
  });

  @override
  List<Object?> get props => [
        access_token,
        token_type,
        is_signup,
        user,
      ];
}

class UserAuthenticateEntity extends BaseEntity {
  UserAuthenticateEntity({
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

  final String? userName;
  final String? email;
  final String? firstName;
  final String? lastName;
  final dynamic profile;
  final dynamic userImage;
  final String? gender;
  final String? mobile;
  final dynamic fullMobileNumber;
  final DateTime? createdAt;
  final int? isMobileVerified;
  final int? isActive;
  final String? latitude;
  final String? longitude;
  final int? evaluation;
  final dynamic country;
  final dynamic stable;
  final List<dynamic>? specializations;

  final List<dynamic>? evaluationsOfUser;

  final List<dynamic>? userEvaluations;

  @override
  List<Object?> get props => [
        id,
        userName,
        email,
        firstName,
        lastName,
        profile,
        userImage,
        gender,
        mobile,
        fullMobileNumber,
        createdAt,
        isMobileVerified,
        isActive,
        latitude,
        longitude,
        evaluation,
        country,
        stable,
        specializations,
        evaluationsOfUser,
        userEvaluations,
      ];
}
