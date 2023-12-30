class TrainersModel {
  TrainersModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String? status;
  static const String statusKey = "status";

  final String? message;
  static const String messageKey = "message";

  final Data? data;
  static const String dataKey = "data";

  factory TrainersModel.fromJson(Map<String, dynamic> json) {
    return TrainersModel(
      status: json["status"],
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

class Data {
  Data({
    required this.trainers,
    required this.lastPage,
  });

  final List<Trainer> trainers;
  static const String trainersKey = "trainers";

  final int? lastPage;
  static const String lastPageKey = "lastPage";

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      trainers: json["trainers"] == null
          ? []
          : List<Trainer>.from(
              json["trainers"]!.map((x) => Trainer.fromJson(x))),
      lastPage: json["lastPage"],
    );
  }

  Map<String, dynamic> toJson() => {
        "trainers": trainers.map((x) => x.toJson()).toList(),
        "lastPage": lastPage,
      };
}

class Trainer {
  Trainer({
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

  final int? id;
  static const String idKey = "id";

  final String? userName;
  static const String userNameKey = "user_name";

  final String? email;
  static const String emailKey = "email";

  final String? firstName;
  static const String firstNameKey = "first_name";

  final String? lastName;
  static const String lastNameKey = "last_name";

  final String? profile;
  static const String profileKey = "profile";

  final String? userImage;
  static const String userImageKey = "user_image";

  final String? gender;
  static const String genderKey = "gender";

  final String? mobile;
  static const String mobileKey = "mobile";

  final String? fullMobileNumber;
  static const String fullMobileNumberKey = "full_mobile_number";

  final DateTime? createdAt;
  static const String createdAtKey = "created_at";

  final int? isMobileVerified;
  static const String isMobileVerifiedKey = "is_mobile_verified";

  final int? isActive;
  static const String isActiveKey = "is_active";

  final String? latitude;
  static const String latitudeKey = "latitude";

  final String? longitude;
  static const String longitudeKey = "longitude";

  final int? evaluation;
  static const String evaluationKey = "evaluation";

  final Country? country;
  static const String countryKey = "country";

  final Stable? stable;
  static const String stableKey = "stable";

  final List<dynamic> specializations;
  static const String specializationsKey = "specializations";

  final List<dynamic> evaluationsOfUser;
  static const String evaluationsOfUserKey = "evaluations_of_user";

  final List<dynamic> userEvaluations;
  static const String userEvaluationsKey = "user_evaluations";

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
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
      country:
          json["country"] == null ? null : Country.fromJson(json["country"]),
      stable: json["stable"] == null ? null : Stable.fromJson(json["stable"]),
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
        "country": country?.toJson(),
        "stable": stable?.toJson(),
        "specializations": specializations.map((x) => x).toList(),
        "evaluations_of_user": evaluationsOfUser.map((x) => x).toList(),
        "user_evaluations": userEvaluations.map((x) => x).toList(),
      };
}

class Country {
  Country({
    required this.id,
    required this.name,
    required this.code,
    required this.dialCode,
    required this.isSelected,
  });

  final int? id;
  static const String idKey = "id";

  final String? name;
  static const String nameKey = "name";

  final String? code;
  static const String codeKey = "code";

  final String? dialCode;
  static const String dialCodeKey = "dial_code";

  final int? isSelected;
  static const String isSelectedKey = "is_selected";

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      dialCode: json["dial_code"],
      isSelected: json["is_selected"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "dial_code": dialCode,
        "is_selected": isSelected,
      };
}

class Stable {
  Stable({
    required this.id,
    required this.name,
    required this.description,
    required this.longitude,
    required this.latitude,
    required this.profileImage,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  final int? id;
  static const String idKey = "id";

  final String? name;
  static const String nameKey = "name";

  final String? description;
  static const String descriptionKey = "description";

  final String? longitude;
  static const String longitudeKey = "longitude";

  final String? latitude;
  static const String latitudeKey = "latitude";

  final String? profileImage;
  static const String profileImageKey = "profile_image";

  final DateTime? createdAt;
  static const String createdAtKey = "created_at";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updated_at";

  final List<ImageData> images;
  static const String imagesKey = "images";

  factory Stable.fromJson(Map<String, dynamic> json) {
    return Stable(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      profileImage: json["profile_image"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      images: json["images"] == null
          ? []
          : List<ImageData>.from(json["images"]!.map((x) => ImageData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "longitude": longitude,
        "latitude": latitude,
        "profile_image": profileImage,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "images": images.map((x) => x?.toJson()).toList(),
      };
}

class ImageData {
  ImageData({
    required this.id,
    required this.image,
    required this.isTop,
    required this.stableId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  static const String idKey = "id";

  final String? image;
  static const String imageKey = "image";

  final int? isTop;
  static const String isTopKey = "is_top";

  final int? stableId;
  static const String stableIdKey = "stable_id";

  final DateTime? createdAt;
  static const String createdAtKey = "created_at";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updated_at";

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json["id"],
      image: json["image"],
      isTop: json["is_top"],
      stableId: json["stable_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "is_top": isTop,
        "stable_id": stableId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
