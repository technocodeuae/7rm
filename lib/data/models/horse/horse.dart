class Horse {
  Horse({
    this.highestBid,
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
     this.address,
     this.startTime,
     this.endTime,
     this.birthDate,
     this.saleDate,
     this.saleTime,
     this.description,
     this.categoryName,
     this.images,
     this.auctionId,
     this.auctionDate,
     this.locationName,
     this.currentBid,
     this.restTime,
     this.isPayed
  });

  final int? id;
  final String? highestBid;
  final String? name;
  final dynamic imageId;
  final String? gender;
  final int? categoryId;
  final String? color;
  final String? location;
  final String? owner;
  final String? ownerMobile;
  final String? price;
  final dynamic address;
  final String? startTime;
  final String? endTime;
  final String? birthDate;
  final dynamic saleDate;
  final dynamic saleTime;
  final String? description;
  final String? categoryName;
  final List<String>? images;
  final int? auctionId;
  final String? auctionDate;
  final String? locationName;
  final dynamic currentBid;
  final String? restTime;
  final bool? isPayed;

  factory Horse.fromJson(Map<String, dynamic> json){
    return Horse(
      id: json["id"],
      name: json["name"],
      imageId: json["image_id"],
      gender: json["gender"],
      categoryId: json["category_id"],
      color: json["color"],
      highestBid : json['highest_bid'],
      location: json["location"],
      owner: json["owner"],
      ownerMobile: json["owner_mobile"],
      price: json["price"],
      address: json["address"],
      startTime: json["start_time"],
      endTime: json["end_time"],
      birthDate: json["birth_date"],
      saleDate: json["sale_date"],
      saleTime: json["sale_time"],
      description: json["description"],
      categoryName: json["category_name"],
      images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
      auctionId: json["Auction_ID"],
      auctionDate: json["Auction_date"],
      locationName: json["location_name"],
      currentBid: json["current_bid"],
      restTime: json["rest_time"],
      isPayed: json["is_payed_?"]
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "highest_bid":highestBid,
    "name": name,
    "image_id": imageId,
    "gender": gender,
    "category_id": categoryId,
    "color": color,
    "location": location,
    "owner": owner,
    "owner_mobile": ownerMobile,
    "price": price,
    "address": address,
    "start_time": startTime,
    "end_time": endTime,
    "birth_date": birthDate,
    "sale_date": saleDate,
    "sale_time": saleTime,
    "description": description,
    "category_name": categoryName,
    "images": images?.map((x) => x).toList(),
    "Auction_ID": auctionId,
    "Auction_date": auctionDate,
    "location_name": locationName,
    "current_bid": currentBid,
    "rest_time": restTime,
    "is_payed_?":isPayed
  };

}
