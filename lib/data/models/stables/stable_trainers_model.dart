class StableTrainersModel {
  StableTrainersModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory StableTrainersModel.fromJson(Map<String, dynamic> json){
    return StableTrainersModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.trainers,
    required this.lastPage,
  });

  final List<Trainer> trainers;
  final int? lastPage;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      trainers: json["trainers"] == null ? [] : List<Trainer>.from(json["trainers"]!.map((x) => Trainer.fromJson(x))),
      lastPage: json["lastPage"],
    );
  }

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
  final String? userName;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? profile;
  final String? userImage;
  final String? gender;
  final String? mobile;
  final String? fullMobileNumber;
  final DateTime? createdAt;
  final int? isMobileVerified;
  final int? isActive;
  final String? latitude;
  final String? longitude;
  final int? evaluation;
  final Country? country;
  final Stable? stable;
  final List<dynamic> specializations;
  final List<dynamic> evaluationsOfUser;
  final List<UserEvaluation> userEvaluations;

  factory Trainer.fromJson(Map<String, dynamic> json){
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
      country: json["country"] == null ? null : Country.fromJson(json["country"]),
      stable: json["stable"] == null ? null : Stable.fromJson(json["stable"]),
      specializations: json["specializations"] == null ? [] : List<dynamic>.from(json["specializations"]!.map((x) => x)),
      evaluationsOfUser: json["evaluations_of_user"] == null ? [] : List<dynamic>.from(json["evaluations_of_user"]!.map((x) => x)),
      userEvaluations: json["user_evaluations"] == null ? [] : List<UserEvaluation>.from(json["user_evaluations"]!.map((x) => UserEvaluation.fromJson(x))),
    );
  }

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
  final String? name;
  final String? code;
  final String? dialCode;
  final int? isSelected;

  factory Country.fromJson(Map<String, dynamic> json){
    return Country(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      dialCode: json["dial_code"],
      isSelected: json["is_selected"],
    );
  }

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
  final String? name;
  final String? description;
  final String? longitude;
  final String? latitude;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ImageData> images;

  factory Stable.fromJson(Map<String, dynamic> json){
    return Stable(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      profileImage: json["profile_image"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      images: json["images"] == null ? [] : List<ImageData>.from(json["images"]!.map((x) => ImageData.fromJson(x))),
    );
  }

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
  final String? image;
  final int? isTop;
  final int? stableId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ImageData.fromJson(Map<String, dynamic> json){
    return ImageData(
      id: json["id"],
      image: json["image"],
      isTop: json["is_top"],
      stableId: json["stable_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class UserEvaluation {
  UserEvaluation({
    required this.id,
    required this.type,
    required this.value,
    required this.comment,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? type;
  final int? value;
  final dynamic comment;
  final dynamic description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory UserEvaluation.fromJson(Map<String, dynamic> json){
    return UserEvaluation(
      id: json["id"],
      type: json["type"],
      value: json["value"],
      comment: json["comment"],
      description: json["description"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
