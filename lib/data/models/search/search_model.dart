class SearchModel {
  SearchModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String? status;
  final String? message;
  final List<Datum> data;

  factory SearchModel.fromJson(Map<String, dynamic> json){
    return SearchModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.description,
    required this.longitude,
    required this.latitude,
    required this.openAt,
    required this.closeAt,
    required this.profileImage,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
    required this.service,
    required this.category,
    required this.evaluations,
  });

  final int? id;
  final String? name;
  final String? description;
  final String? longitude;
  final String? latitude;
  final String? openAt;
  final String? closeAt;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Image> images;
  final List<DatumService> service;
  final List<dynamic> category;
  final List<Evaluation> evaluations;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      openAt: json["open_at"],
      closeAt: json["close_at"],
      profileImage: json["profile_image"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
      service: json["service"] == null ? [] : List<DatumService>.from(json["service"]!.map((x) => DatumService.fromJson(x))),
      category: json["category"] == null ? [] : List<dynamic>.from(json["category"]!.map((x) => x)),
      evaluations: json["evaluations"] == null ? [] : List<Evaluation>.from(json["evaluations"]!.map((x) => Evaluation.fromJson(x))),
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

class Image {
  Image({
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

  factory Image.fromJson(Map<String, dynamic> json){
    return Image(
      id: json["id"],
      image: json["image"],
      isTop: json["is_top"],
      stableId: json["stable_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class DatumService {
  DatumService({
    required this.processTime,
    required this.employeesNb,
    required this.service,
  });

  final String? processTime;
  final int? employeesNb;
  final List<ServiceService> service;

  factory DatumService.fromJson(Map<String, dynamic> json){
    return DatumService(
      processTime: json["process_time"],
      employeesNb: json["employees_nb"],
      service: json["service"] == null ? [] : List<ServiceService>.from(json["service"]!.map((x) => ServiceService.fromJson(x))),
    );
  }

}

class ServiceService {
  ServiceService({
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
  final int? sortOrder;
  final String? imagePath;
  final String? headImagePath;
  final int? isActive;
  final int? isTopService;
  final dynamic parentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic> childServices;

  factory ServiceService.fromJson(Map<String, dynamic> json){
    return ServiceService(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      sortOrder: json["sort_order"],
      imagePath: json["image_path"],
      headImagePath: json["head_image_path"],
      isActive: json["is_active"],
      isTopService: json["is_top_service"],
      parentId: json["parent_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      childServices: json["child_services"] == null ? [] : List<dynamic>.from(json["child_services"]!.map((x) => x)),
    );
  }

}
