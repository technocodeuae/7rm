class ShowTrainerModel {
  ShowTrainerModel({
    required this.message,
    required this.userId,
    required this.userName,
    required this.email,
    required this.workName,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.mobile,
    required this.userImage,
    required this.dateOfBirth,
    required this.user,
    required this.averageEvaluations,
    required this.openingDaysHours,
    required this.images,
    required this.isActive,
    required this.country,
  });

  final String? message;
  final int? userId;
  final String? userName;
  final String? email;
  final String? workName;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? mobile;
  final String? userImage;
  final String? country;
  final DateTime? dateOfBirth;
  final int? isActive;
  final String? user;
  final double? averageEvaluations;
  final OpeningDaysHours? openingDaysHours;
  final List<ImageData> images;

  factory ShowTrainerModel.fromJson(Map<String, dynamic> json){
    return ShowTrainerModel(
      message: json["message"],
      userId: json["user_id"],
      userName: json["user_name"],
      country: json["country"],
      email: json["email"],
      workName: json["work_name"],
      isActive: json["is_active"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      gender: json["gender"],
      mobile: json["mobile"],
      userImage: json["user_image"],
      dateOfBirth: DateTime.tryParse(json["date_of_birth"] ?? ""),
      user: json["user"],
      averageEvaluations:double.parse( json["average_evaluations"]),
      openingDaysHours: json["opening_days_hours"] == null ? null : OpeningDaysHours.fromJson(json["opening_days_hours"]),
      images: json["images"] == null ? [] : List<ImageData>.from(json["images"]!.map((x) => ImageData.fromJson(x))),
    );
  }

}

class ImageData {
  ImageData({
    required this.id,
    required this.image,
    required this.stableId,
    required this.isTop,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? image;
  final int? stableId;
  final int? isTop;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ImageData.fromJson(Map<String, dynamic> json){
    return ImageData(
      id: json["id"],
      image: json["image"],
      stableId: json["stable_id"],
      isTop: json["is_top"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class OpeningDaysHours {
  OpeningDaysHours({
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  final List<Day> thursday;
  final List<Day> friday;
  final List<Day> saturday;
  final List<Day> sunday;

  factory OpeningDaysHours.fromJson(Map<String, dynamic> json){
    return OpeningDaysHours(
      thursday: json["Thursday"] == null ? [] : List<Day>.from(json["Thursday"]!.map((x) => Day.fromJson(x))),
      friday: json["Friday"] == null ? [] : List<Day>.from(json["Friday"]!.map((x) => Day.fromJson(x))),
      saturday: json["Saturday"] == null ? [] : List<Day>.from(json["Saturday"]!.map((x) => Day.fromJson(x))),
      sunday: json["Sunday"] == null ? [] : List<Day>.from(json["Sunday"]!.map((x) => Day.fromJson(x))),
    );
  }

}

class Day {
  Day({
    required this.openAt,
    required this.closeAt,
  });

  final String? openAt;
  final String? closeAt;

  factory Day.fromJson(Map<String, dynamic> json){
    return Day(
      openAt: json["open_at"],
      closeAt: json["close_at"],
    );
  }

}
