class AddOrderModel {
  AddOrderModel({
    required this.message,
    required this.data,
  });

  final String? message;
  final List<Datum> data;

  factory AddOrderModel.fromJson(Map<String, dynamic> json){
    return AddOrderModel(
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.stableId,
    required this.paymentMethod,
    required this.bookingDate,
    required this.stableServiceId,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  final String? stableId;
  final String? paymentMethod;
  final String? bookingDate;
  final String? stableServiceId;
  final int? userId;
  final String? updatedAt;
  final String? createdAt;
  final int? id;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      stableId: json["stable_id"],
      paymentMethod: json["payment_method"],
      bookingDate: json["booking_date"].toString(),
      stableServiceId: json["stable_service_id"],
      userId: json["user_id"],
      updatedAt: json["updated_at"].toString(),
      createdAt: json["created_at"].toString(),
      id: json["id"],
    );
  }

}
