class BookingUserInStableModel {
  BookingUserInStableModel({
    required this.message,
    required this.userBookings,
  });

  final String? message;
  final List<UserBooking> userBookings;

  factory BookingUserInStableModel.fromJson(Map<String, dynamic> json){
    return BookingUserInStableModel(
      message: json["message"],
      userBookings: json["user_bookings"] == null ? [] : List<UserBooking>.from(json["user_bookings"]!.map((x) => UserBooking.fromJson(x))),
    );
  }

}

class UserBooking {
  UserBooking({
    required this.bookingId,
    required this.bookingDate,
    required this.paymentMethod,
    required this.specialistId,
    required this.specialistFirstName,
    required this.specialistSecondName,
    required this.stableServiceName,
    required this.stableServicePrice,
    required this.stableName,
    required this.profileImage,
  });

  final int? bookingId;
  final DateTime? bookingDate;
  final String? paymentMethod;
  final int? specialistId;
  final String? specialistFirstName;
  final String? specialistSecondName;
  final String? stableServiceName;
  final int? stableServicePrice;
  final String? stableName;
  final String? profileImage;

  factory UserBooking.fromJson(Map<String, dynamic> json){
    return UserBooking(
      bookingId: json["booking_id"],
      bookingDate: DateTime.tryParse(json["booking_date"] ?? ""),
      paymentMethod: json["payment_method"],
      specialistId: json["specialist_id"],
      specialistFirstName: json["specialist_firstName"],
      specialistSecondName: json["specialist_secondName"],
      stableServiceName: json["stable_service_name"],
      stableServicePrice: json["stable_service_price"],
      stableName: json["stable_name"],
      profileImage: json["profile_image"],
    );
  }

}
