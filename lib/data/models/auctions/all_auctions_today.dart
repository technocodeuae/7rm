class AuctionsToday {
  AuctionsToday({
    required this.getHorsesForTodaysAuctions,
  });

  final List<GetHorsesForTodaysAuction> getHorsesForTodaysAuctions;

  factory AuctionsToday.fromJson(Map<String, dynamic> json){
    return AuctionsToday(
      getHorsesForTodaysAuctions: json["getHorsesForTodaysAuctions"] == null ? [] : List<GetHorsesForTodaysAuction>.from(json["getHorsesForTodaysAuctions"]!.map((x) => GetHorsesForTodaysAuction.fromJson(x))),
    );
  }

}

class GetHorsesForTodaysAuction {
  GetHorsesForTodaysAuction({
    required this.id,
    required this.auctionId,
    required this.sire,
    required this.dam,
    required this.gender,
    required this.birthDate,
    required this.price,
    required this.date,
    required this.remainingTime,
    required this.images,
    required this.averageEvaluation,
  });

  final int? id;
  final int? auctionId;
  final String? sire;
  final String? dam;
  final String? gender;
  final DateTime? birthDate;
  final String? price;
  final DateTime? date;
  final String? remainingTime;
  final List<Image> images;
  final String? averageEvaluation;

  factory GetHorsesForTodaysAuction.fromJson(Map<String, dynamic> json){
    return GetHorsesForTodaysAuction(
      id: json["id"],
      auctionId: json["auction_id"],
      sire: json["Sire"],
      dam: json["Dam"],
      gender: json["Gender"],
      birthDate: DateTime.tryParse(json["Birth Date"] ?? ""),
      price: json["Price"],
      date: DateTime.tryParse(json["date"] ?? ""),
      remainingTime: json["Remaining_time"],
      images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
      averageEvaluation: json["average_evaluation"],
    );
  }

}

class Image {
  Image({
    required this.id,
    required this.image,
    required this.horseId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? image;
  final int? horseId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Image.fromJson(Map<String, dynamic> json){
    return Image(
      id: json["id"],
      image: json["image"],
      horseId: json["horse_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
