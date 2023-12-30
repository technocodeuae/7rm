class StableInformationModel {
  StableInformationModel({
    required this.message,
    required this.stableDetails,
    required this.stableServices,
    required this.stableDays,
    required this.stableTrainer,
    required this.stableImages,
  });

  final String? message;
  final StableDetails? stableDetails;
  final List<StableService> stableServices;
  final List<String> stableDays;
  final List<StableTrainer> stableTrainer;
  final List<StableImage> stableImages;

  factory StableInformationModel.fromJson(Map<String, dynamic> json){
    return StableInformationModel(
      message: json["message"],
      stableDetails: json["stable_details"] == null ? null : StableDetails.fromJson(json["stable_details"]),
      stableServices: json["stable_services"] == null ? [] : List<StableService>.from(json["stable_services"]!.map((x) => StableService.fromJson(x))),
      stableDays: json["stable_days"] == null ? [] : List<String>.from(json["stable_days"]!.map((x) => x)),
      stableTrainer: json["stable_trainer"] == null ? [] : List<StableTrainer>.from(json["stable_trainer"]!.map((x) => StableTrainer.fromJson(x))),
      stableImages: json["stable_images"] == null ? [] : List<StableImage>.from(json["stable_images"]!.map((x) => StableImage.fromJson(x))),
    );
  }

}

class StableDetails {
  StableDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.longitude,
    required this.latitude,
    required this.openAt,
    required this.closeAt,
    required this.profileImage,
    required this.packages,
  });

  final int? id;
  final String? name;
  final String? description;
  final String? longitude;
  final String? latitude;
  final String? openAt;
  final String? closeAt;
  final String? profileImage;
  final List<Package> packages;

  factory StableDetails.fromJson(Map<String, dynamic> json){
    return StableDetails(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      openAt: json["open_at"],
      closeAt: json["close_at"],
      profileImage: json["profile_image"],
      packages: json["packages"] == null ? [] : List<Package>.from(json["packages"]!.map((x) => Package.fromJson(x))),
    );
  }

}

class Package {
  Package({
    required this.id,
    required this.period,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.services,
  });

  final int? id;
  final int? period;
  final String? name;
  final String? description;
  final int? price;
  final String? image;
  final List<Service> services;

  factory Package.fromJson(Map<String, dynamic> json){
    return Package(
      id: json["id"],
      period: json["period"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      image: json["image"],
      services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
    );
  }

}

class Service {
  Service({
    required this.id,
    required this.name,
    required this.items,
    required this.price,
    required this.packageId,
    required this.createdAt,
    required this.updatedAt,
    required this.service,
  });

  final int? id;
  final String? name;
  final dynamic items;
  final dynamic price;
  final int? packageId;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic service;

  factory Service.fromJson(Map<String, dynamic> json){
    return Service(
      id: json["id"],
      name: json["name"],
      items: json["items"],
      price: json["price"],
      packageId: json["package_id"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      service: json["service"],
    );
  }

}

class StableImage {
  StableImage({
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

  factory StableImage.fromJson(Map<String, dynamic> json){
    return StableImage(
      id: json["id"],
      image: json["image"],
      isTop: json["is_top"],
      stableId: json["stable_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class StableService {
  StableService({
    required this.id,
    required this.name,
    required this.price,
    required this.sortOrder,
    required this.imagePath,
    required this.headImagePath,
    required this.isActive,
    required this.isTopService,
    required this.parentId,
    required this.createdAt,
    required this.updatedAt,
    required this.childServices,
  });

  final int? id;
  final String? name;
  final int? price;
  final dynamic sortOrder;
  final String? imagePath;
  final dynamic headImagePath;
  final dynamic isActive;
  final int? isTopService;
  final dynamic parentId;
  final dynamic createdAt;
  final dynamic updatedAt;
  final List<dynamic> childServices;

  factory StableService.fromJson(Map<String, dynamic> json){
    return StableService(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      sortOrder: json["sort_order"],
      imagePath: json["image_path"],
      headImagePath: json["head_image_path"],
      isActive: json["is_active"],
      isTopService: json["is_top_service"],
      parentId: json["parent_id"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      childServices: json["child_services"] == null ? [] : List<dynamic>.from(json["child_services"]!.map((x) => x)),
    );
  }

}

class StableTrainer {
  StableTrainer({
    required this.id,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
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
  final dynamic userName;
  final dynamic email;
  final String? firstName;
  final String? lastName;
  final String? userImage;
  final dynamic gender;
  final dynamic mobile;
  final dynamic fullMobileNumber;
  final dynamic createdAt;
  final dynamic isMobileVerified;
  final dynamic isActive;
  final dynamic latitude;
  final dynamic longitude;
  final int? evaluation;
  final dynamic country;
  final dynamic stable;
  final List<dynamic> specializations;
  final List<dynamic> evaluationsOfUser;
  final List<UserEvaluation> userEvaluations;

  factory StableTrainer.fromJson(Map<String, dynamic> json){
    return StableTrainer(
      id: json["id"],
      userName: json["user_name"],
      email: json["email"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      userImage: json["user_image"],
      gender: json["gender"],
      mobile: json["mobile"],
      fullMobileNumber: json["full_mobile_number"],
      createdAt: json["created_at"],
      isMobileVerified: json["is_mobile_verified"],
      isActive: json["is_active"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      evaluation: json["evaluation"],
      country: json["country"],
      stable: json["stable"],
      specializations: json["specializations"] == null ? [] : List<dynamic>.from(json["specializations"]!.map((x) => x)),
      evaluationsOfUser: json["evaluations_of_user"] == null ? [] : List<dynamic>.from(json["evaluations_of_user"]!.map((x) => x)),
      userEvaluations: json["user_evaluations"] == null ? [] : List<UserEvaluation>.from(json["user_evaluations"]!.map((x) => UserEvaluation.fromJson(x))),
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
