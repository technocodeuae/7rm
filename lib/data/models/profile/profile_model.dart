class ProfileModelMe {
  ProfileModelMe({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  static const String statusKey = "status";

  final dynamic message;
  static const String messageKey = "message";

  final Data? data;
  static const String dataKey = "data";

  factory ProfileModelMe.fromJson(Map<String, dynamic> json) {
    return ProfileModelMe(
      status: json["status"] ?? "",
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}
/////////

class Data {
  Data({
    required this.id,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profile,
    required this.userImage,
    required this.gender,
    required this.mobile,
    required this.fullMobileNumber,
    required this.createdAt,
    required this.isMobileVerified,
    required this.isActive,
    required this.latitude,
    required this.longitude,
    required this.evaluation,
    required this.country,
    required this.stable,
    required this.specializations,
    required this.evaluationsOfUser,
    required this.userEvaluations,
  });

  final int id;
  static const String idKey = "id";

  final String userName;
  static const String userNameKey = "user_name";

  final String email;
  static const String emailKey = "email";

  final String firstName;
  static const String firstNameKey = "first_name";

  final String lastName;
  static const String lastNameKey = "last_name";

  final dynamic profile;
  static const String profileKey = "profile";

  final dynamic userImage;
  static const String userImageKey = "user_image";

  final String gender;
  static const String genderKey = "gender";

  final String mobile;
  static const String mobileKey = "mobile";

  final dynamic fullMobileNumber;
  static const String fullMobileNumberKey = "full_mobile_number";

  final DateTime? createdAt;
  static const String createdAtKey = "created_at";

  final int isMobileVerified;
  static const String isMobileVerifiedKey = "is_mobile_verified";

  final int isActive;
  static const String isActiveKey = "is_active";

  final dynamic latitude;
  static const String latitudeKey = "latitude";

  final dynamic longitude;
  static const String longitudeKey = "longitude";

  final int evaluation;
  static const String evaluationKey = "evaluation";

  final dynamic country;
  static const String countryKey = "country";

  final dynamic stable;
  static const String stableKey = "stable";

  final List<dynamic> specializations;
  static const String specializationsKey = "specializations";

  final List<dynamic> evaluationsOfUser;
  static const String evaluationsOfUserKey = "evaluations_of_user";

  final List<dynamic> userEvaluations;
  static const String userEvaluationsKey = "user_evaluations";

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"] ?? 0,
      userName: json["user_name"] ?? "",
      email: json["email"] ?? "",
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      profile: json["profile"],
      userImage: json["user_image"],
      gender: json["gender"] ?? "",
      mobile: json["mobile"] ?? "",
      fullMobileNumber: json["full_mobile_number"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      isMobileVerified: json["is_mobile_verified"] ?? 0,
      isActive: json["is_active"] ?? 0,
      latitude: json["latitude"],
      longitude: json["longitude"],
      evaluation: json["evaluation"] ?? 0,
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
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "profile": profile,
        "user_image": userImage,
        "gender": gender,
        "mobile": mobile,
        "full_mobile_number": fullMobileNumber,
        "created_at": createdAt?.toIso8601String(),
        "is_mobile_verified": isMobileVerified,
        "is_active": isActive,
        "latitude": latitude,
        "longitude": longitude,
        "evaluation": evaluation,
        "country": country,
        "stable": stable,
        "specializations": specializations.map((x) => x).toList(),
        "evaluations_of_user": evaluationsOfUser.map((x) => x).toList(),
        "user_evaluations": userEvaluations.map((x) => x).toList(),
      };
}
