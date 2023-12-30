class ServicesModel {
  ServicesModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
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
    this.id,
    this.name,
    this.price,
    this.sortOrder,
    this.imagePath,
    this.headImagePath,
    this.isActive,
    this.isTopService,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.childServices,
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
  final List<dynamic>? childServices;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
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
      childServices: json["child_services"] == null
          ? []
          : List<dynamic>.from(json["child_services"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "sort_order": sortOrder,
        "image_path": imagePath,
        "head_image_path": headImagePath,
        "is_active": isActive,
        "is_top_service": isTopService,
        "parent_id": parentId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "child_services": childServices?.map((x) => x).toList(),
      };
}
