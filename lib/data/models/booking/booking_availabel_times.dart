class BookingAvailableTimes {
  BookingAvailableTimes({
    required this.message,
    required this.stable,
    required this.service,
    required this.specialistsAvailableTimes,
    required this.allAvailableTimes,
  });

  final String? message;
  final List<Stable> stable;
  final List<BookingAvailableTimesService> service;
  final List<SpecialistsAvailableTime> specialistsAvailableTimes;
  final List<String> allAvailableTimes;

  factory BookingAvailableTimes.fromJson(Map<String, dynamic> json){
    return BookingAvailableTimes(
      message: json["message"],
      stable: json["stable"] == null ? [] : List<Stable>.from(json["stable"]!.map((x) => Stable.fromJson(x))),
      service: json["service"] == null ? [] : List<BookingAvailableTimesService>.from(json["service"]!.map((x) => BookingAvailableTimesService.fromJson(x))),
      specialistsAvailableTimes: json["specialists_available_times"] == null ? [] : List<SpecialistsAvailableTime>.from(json["specialists_available_times"]!.map((x) => SpecialistsAvailableTime.fromJson(x))),
      allAvailableTimes: json["allAvailableTimes"] == null ? [] : List<String>.from(json["allAvailableTimes"]!.map((x) => x)),

    );
  }

}

class BookingAvailableTimesService {
  BookingAvailableTimesService({
    required this.id,
    required this.parentId,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.headImagePath,
    required this.isActive,
    required this.isTopService,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final dynamic parentId;
  final String? name;
  final int? price;
  final String? imagePath;
  final String? headImagePath;
  final int? isActive;
  final int? isTopService;
  final int? sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory BookingAvailableTimesService.fromJson(Map<String, dynamic> json){
    return BookingAvailableTimesService(
      id: json["id"],
      parentId: json["parent_id"],
      name: json["name"],
      price: json["price"],
      imagePath: json["image_path"],
      headImagePath: json["head_image_path"],
      isActive: json["is_active"],
      isTopService: json["is_top_service"],
      sortOrder: json["sort_order"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class SpecialistsAvailableTime {
  SpecialistsAvailableTime({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userImage,
    required this.availableTimes,
  });

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? userImage;
  final List<String> availableTimes;

  factory SpecialistsAvailableTime.fromJson(Map<String, dynamic> json){
    return SpecialistsAvailableTime(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      userImage: json["user_image"],
      availableTimes: json["available_times"] == null ? [] : List<String>.from(json["available_times"]!.map((x) => x)),
    );
  }

}

class Stable {
  Stable({
    required this.id,
    required this.name,
    required this.description,
    required this.openAt,
    required this.closeAt,
    required this.longitude,
    required this.latitude,
    required this.profileImage,
    required this.createdAt,
    required this.updatedAt,
    required this.evaluations,
    required this.services,
  });

  final int? id;
  final String? name;
  final String? description;
  final String? openAt;
  final String? closeAt;
  final String? longitude;
  final String? latitude;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Evaluation> evaluations;
  final List<StableService> services;

  factory Stable.fromJson(Map<String, dynamic> json){
    return Stable(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      openAt: json["open_at"],
      closeAt: json["close_at"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      profileImage: json["profile_image"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      evaluations: json["evaluations"] == null ? [] : List<Evaluation>.from(json["evaluations"]!.map((x) => Evaluation.fromJson(x))),
      services: json["services"] == null ? [] : List<StableService>.from(json["services"]!.map((x) => StableService.fromJson(x))),
    );
  }

}

class Evaluation {
  Evaluation({
    required this.stableId,
    required this.averageEvaluation,
  });

  final int? stableId;
  final String? averageEvaluation;

  factory Evaluation.fromJson(Map<String, dynamic> json){
    return Evaluation(
      stableId: json["stable_id"],
      averageEvaluation: json["average_evaluation"].toString(),
    );
  }

}

class StableService {
  StableService({
    required this.id,
    required this.name,
    required this.pivot,
  });

  final int? id;
  final String? name;
  final Pivot? pivot;

  factory StableService.fromJson(Map<String, dynamic> json){
    return StableService(
      id: json["id"],
      name: json["name"],
      pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
    );
  }

}

class Pivot {
  Pivot({
    required this.stableId,
    required this.serviceId,
  });

  final int? stableId;
  final int? serviceId;

  factory Pivot.fromJson(Map<String, dynamic> json){
    return Pivot(
      stableId: json["stable_id"],
      serviceId: json["service_id"],
    );
  }

}
