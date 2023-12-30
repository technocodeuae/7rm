class FavoriteModel {
  FavoriteModel({
    required this.message,
    required this.horse,
  });

  final String? message;
  final List<HorseElement> horse;

  factory FavoriteModel.fromJson(Map<String, dynamic> json){
    return FavoriteModel(
      message: json["message"],
      horse: json["horse"] == null ? [] : List<HorseElement>.from(json["horse"]!.map((x) => HorseElement.fromJson(x))),
    );
  }

}

class HorseElement {
  HorseElement({
    required this.id,
    required this.userId,
    required this.stableId,
    required this.horseId,
    required this.createdAt,
    required this.updatedAt,
    required this.horse,
  });

  final int? id;
  final int? userId;
  final int? stableId;
  final int? horseId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final HorseHorse? horse;

  factory HorseElement.fromJson(Map<String, dynamic> json){
    return HorseElement(
      id: json["id"],
      userId: json["user_id"],
      stableId: json["stable_id"],
      horseId: json["horse_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      horse: json["horse"] == null ? null : HorseHorse.fromJson(json["horse"]),
    );
  }

}

class HorseHorse {
  HorseHorse({
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
    required this.currentBid,
    required this.adress,
    required this.startTime,
    required this.endTime,
    required this.birthDate,
    required this.saleDate,
    required this.saleTime,
    required this.winnerId,
    required this.description,
    required this.insuranceValue,
    required this.auctionSubscription,
    required this.createdAt,
    required this.updatedAt,
    required this.auctionId,
    required this.auctions,
  });

  final int? id;
  final String? name;
  final dynamic imageId;
  final String? gender;
  final int? categoryId;
  final String? color;
  final String? location;
  final String? owner;
  final String? ownerMobile;
  final String? price;
  final String? currentBid;
  final String? adress;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? birthDate;
  final dynamic saleDate;
  final dynamic saleTime;
  final int? winnerId;
  final String? description;
  final dynamic insuranceValue;
  final dynamic auctionSubscription;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? auctionId;
  final List<dynamic> auctions;

  factory HorseHorse.fromJson(Map<String, dynamic> json){
    return HorseHorse(
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
      currentBid: json["current_bid"],
      adress: json["adress"],
      startTime: DateTime.tryParse(json["start_time"] ?? ""),
      endTime: DateTime.tryParse(json["end_time"] ?? ""),
      birthDate: DateTime.tryParse(json["birth_date"] ?? ""),
      saleDate: json["sale_date"],
      saleTime: json["sale_time"],
      winnerId: json["winner_id"],
      description: json["description"],
      insuranceValue: json["insurance_value"],
      auctionSubscription: json["auction_subscription"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      auctionId: json["auction_id"],
      auctions: json["auctions"] == null ? [] : List<dynamic>.from(json["auctions"]!.map((x) => x)),
    );
  }

}
