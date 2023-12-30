class MyAuctions {
  MyAuctions({
    this.message,
    this.auctions,
  });

  final String? message;
  final List<AuctionElement>? auctions;

  factory MyAuctions.fromJson(Map<String, dynamic> json) {
    return MyAuctions(
      message: json["message"],
      auctions: json["auctions"] == null
          ? []
          : List<AuctionElement>.from(
              json["auctions"]!.map((x) => AuctionElement.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "auctions": auctions?.map((x) => x.toJson()).toList(),
      };
}

class AuctionElement {
  AuctionElement({
    this.auction,
    this.highestBid,
  });

  final AuctionAuction? auction;
  final HighestBid? highestBid;

  factory AuctionElement.fromJson(Map<String, dynamic> json) {
    return AuctionElement(
      auction: json["auction"] == null
          ? null
          : AuctionAuction.fromJson(json["auction"]),
      highestBid: json["highest_bid"] == null
          ? null
          : HighestBid.fromJson(json["highest_bid"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "auction": auction?.toJson(),
        "highest_bid": highestBid?.toJson(),
      };
}

class AuctionAuction {
  AuctionAuction({
    this.id,
    this.title,
    this.description,
    this.date,
    this.longitude,
    this.latitude,
    this.locationName,
    this.insuranceValue,
    this.auctionSubscription,
    this.currentBid,
    this.startTime,
    this.endTime,
    this.winnerId,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? title;
  final String? description;
  final String? date;
  final String? longitude;
  final String? latitude;
  final String? locationName;
  final String? insuranceValue;
  final String? auctionSubscription;
  final dynamic currentBid;
  final String? startTime;
  final String? endTime;
  final int? winnerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AuctionAuction.fromJson(Map<String, dynamic> json) {
    return AuctionAuction(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      date: json["date"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      locationName: json["location_name"],
      insuranceValue: json["insurance_value"],
      auctionSubscription: json["auction_subscription"],
      currentBid: json["current_bid"],
      startTime: json["start_time"],
      endTime: json["end_time"],
      winnerId: json["winner_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date,
        "longitude": longitude,
        "latitude": latitude,
        "location_name": locationName,
        "insurance_value": insuranceValue,
        "auction_subscription": auctionSubscription,
        "current_bid": currentBid,
        "start_time": startTime,
        "end_time": endTime,
        "winner_id": winnerId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

//
class HighestBid {
  HighestBid({
    this.id,
    this.auctionId,
    this.horseId,
    this.userId,
    this.value,
    this.biddingTime,
    this.createdAt,
    this.updatedAt,
    this.horse,
  });

  final int? id;
  final int? auctionId;
  final int? horseId;
  final int? userId;
  final String? value;
  final String? biddingTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Horse? horse;

  factory HighestBid.fromJson(Map<String, dynamic> json) {
    return HighestBid(
      id: json["id"],
      auctionId: json["auction_id"],
      horseId: json["horse_id"],
      userId: json["user_id"],
      value: json["value"],
      biddingTime: json["Bidding_time"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      horse: json["horse"] == null ? null : Horse.fromJson(json["horse"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "auction_id": auctionId,
        "horse_id": horseId,
        "user_id": userId,
        "value": value,
        "Bidding_time": biddingTime,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "horse": horse?.toJson(),
      };
}

class Horse {
  Horse({
    this.id,
    this.name,
    this.imageId,
    this.gender,
    this.categoryId,
    this.color,
    this.location,
    this.owner,
    this.ownerMobile,
    this.price,
    this.adress,
    this.startTime,
    this.endTime,
    this.birthDate,
    this.saleDate,
    this.saleTime,
    this.description,
    this.createdAt,
    this.updatedAt,
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
  final String? adress;
  final dynamic startTime;
  final dynamic endTime;
  final String? birthDate;
  final dynamic saleDate;
  final dynamic saleTime;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Horse.fromJson(Map<String, dynamic> json) {
    return Horse(
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
      startTime: json["start_time"],
      endTime: json["end_time"],
      birthDate: json["birth_date"],
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
        "start_time": startTime,
        "end_time": endTime,
        "birth_date": birthDate,
        "sale_date": saleDate,
        "sale_time": saleTime,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
