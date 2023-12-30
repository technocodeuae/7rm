class FiltersModel {
  FiltersModel({
    required this.status,
    required this.message,
    required this.data,
  });
//
  final bool? status;
  static const String statusKey = "status";

  final String? message;
  static const String messageKey = "message";

  final List<Datum> data;
  static const String dataKey = "data";

  factory FiltersModel.fromJson(Map<String, dynamic> json) {
    return FiltersModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.map((x) => x?.toJson()).toList(),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.imageId,
    required this.gender,
    required this.categoryId,
    required this.color,
    required this.location,
    required this.owner,
    required this.ownerMobile,
    required this.price,
    required this.adress,
    required this.birthDate,
    required this.saleDate,
    required this.saleTime,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  static const String idKey = "id";

  final String? name;
  static const String nameKey = "name";

  final dynamic imageId;
  static const String imageIdKey = "image_id";

  final String? gender;
  static const String genderKey = "gender";

  final int? categoryId;
  static const String categoryIdKey = "category_id";

  final String? color;
  static const String colorKey = "color";

  final String? location;
  static const String locationKey = "location";

  final String? owner;
  static const String ownerKey = "owner";

  final String? ownerMobile;
  static const String ownerMobileKey = "owner_mobile";

  final String? price;
  static const String priceKey = "price";

  final String? adress;
  static const String adressKey = "adress";

  final DateTime? birthDate;
  static const String birthDateKey = "birth_date";

  final dynamic saleDate;
  static const String saleDateKey = "sale_date";

  final dynamic saleTime;
  static const String saleTimeKey = "sale_time";

  final String? description;
  static const String descriptionKey = "description";

  final DateTime? createdAt;
  static const String createdAtKey = "created_at";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updated_at";

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      name: json["name"],
      imageId: json["image_id"],
      gender: json["gender"],
      categoryId: json["category_id"],
      color: json["color"],
      location: json["location"],
      owner: json["owner"],
      ownerMobile: json["owner_mobile"],
      price: json["price"],
      adress: json["adress"],
      birthDate: DateTime.tryParse(json["birth_date"] ?? ""),
      saleDate: json["sale_date"],
      saleTime: json["sale_time"],
      description: json["description"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_id": imageId,
        "gender": gender,
        "category_id": categoryId,
        "color": color,
        "location": location,
        "owner": owner,
        "owner_mobile": ownerMobile,
        "price": price,
        "adress": adress,
        "birth_date": birthDate?.toIso8601String(),
        "sale_date": saleDate,
        "sale_time": saleTime,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
