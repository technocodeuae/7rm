class AuctionCalendarModel {
  AuctionCalendarModel({
    required this.message,
    required this.totalUpcomingAuctions,
    required this.totalTodaysAuctions,
    required this.upcomingAuctions,
  });

  final String? message;
  final int? totalUpcomingAuctions;
  final int? totalTodaysAuctions;
  final List<UpcomingAuction> upcomingAuctions;

  factory AuctionCalendarModel.fromJson(Map<String, dynamic> json){
    return AuctionCalendarModel(
      message: json["message"],
      totalUpcomingAuctions: json["totalUpcomingAuctions"],
      totalTodaysAuctions: json["totalTodaysAuctions"],
      upcomingAuctions: json["upcomingAuctions"] == null ? [] : List<UpcomingAuction>.from(json["upcomingAuctions"]!.map((x) => UpcomingAuction.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "totalUpcomingAuctions": totalUpcomingAuctions,
    "totalTodaysAuctions": totalTodaysAuctions,
    "upcomingAuctions": upcomingAuctions.map((x) => x.toJson()).toList(),
  };

}

class UpcomingAuction {
  UpcomingAuction({
    required this.auctionId,
    required this.title,
    required this.date,
  });

  final int? auctionId;
  final String? title;
  final String? date;

  factory UpcomingAuction.fromJson(Map<String, dynamic> json){
    return UpcomingAuction(
      auctionId: json["auction_id"],
      title: json["title"],
      date: json["date"],
    );
  }

  Map<String, dynamic> toJson() => {
    "auction_id": auctionId,
    "title": title,
    "date": date,
  };

}
