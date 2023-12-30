class SpecificPackageModel {
  SpecificPackageModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory SpecificPackageModel.fromJson(Map<String, dynamic> json){
    return SpecificPackageModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.period,
    required this.name,
    required this.description,
    required this.price,
    required this.servicesCount,
    required this.isActive,
    required this.sortOrder,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.stables,
    required this.currency,
    required this.services,
  });

  final int? id;
  final int? period;
  final String? name;
  final String? description;
  final int? price;
  final int? servicesCount;
  final int? isActive;
  final int? sortOrder;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Stable> stables;
  final Currency? currency;
  final List<ServiceElement> services;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      period: json["period"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      servicesCount: json["services_count"],
      isActive: json["is_active"],
      sortOrder: json["sort_order"],
      image: json["image"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      stables: json["stables"] == null ? [] : List<Stable>.from(json["stables"]!.map((x) => Stable.fromJson(x))),
      currency: json["currency"] == null ? null : Currency.fromJson(json["currency"]),
      services: json["services"] == null ? [] : List<ServiceElement>.from(json["services"]!.map((x) => ServiceElement.fromJson(x))),
    );
  }

}

class Currency {
  Currency({
    required this.id,
    required this.name,
    required this.exchangeRate,
    required this.shortcut,
    required this.sortOrder,
    required this.isDefault,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? exchangeRate;
  final String? shortcut;
  final int? sortOrder;
  final int? isDefault;
  final int? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Currency.fromJson(Map<String, dynamic> json){
    return Currency(
      id: json["id"],
      name: json["name"],
      exchangeRate: json["exchange_rate"].toString(),
      shortcut: json["shortcut"],
      sortOrder: json["sort_order"],
      isDefault: json["is_default"],
      isActive: json["is_active"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class ServiceElement {
  ServiceElement({
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
  final int? items;
  final int? price;
  final int? packageId;
  final dynamic createdAt;
  final dynamic updatedAt;
  final ServiceService? service;

  factory ServiceElement.fromJson(Map<String, dynamic> json){
    return ServiceElement(
      id: json["id"],
      name: json["name"],
      items: json["items"],
      price: json["price"],
      packageId: json["package_id"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      service: json["service"] == null ? null : ServiceService.fromJson(json["service"]),
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
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  final int? id;
  final String? name;
  final String? description;
  final String? openAt;
  final String? closeAt;
  final String? longitude;
  final String? latitude;
  final String? profileImage;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Pivot? pivot;

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
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
    );
  }

}

class Pivot {
  Pivot({
    required this.packageId,
    required this.stableId,
    required this.servicesUsedCount,
    required this.startAt,
    required this.endAt,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? packageId;
  final int? stableId;
  final int? servicesUsedCount;
  final DateTime? startAt;
  final DateTime? endAt;
  final String? status;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory Pivot.fromJson(Map<String, dynamic> json){
    return Pivot(
      packageId: json["package_id"],
      stableId: json["stable_id"],
      servicesUsedCount: json["services_used_count"],
      startAt: DateTime.tryParse(json["start_at"] ?? ""),
      endAt: DateTime.tryParse(json["end_at"] ?? ""),
      status: json["status"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

}
