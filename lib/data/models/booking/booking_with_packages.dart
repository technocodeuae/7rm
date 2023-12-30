class BookingWithPackageModel {
  BookingWithPackageModel({
    required this.message,
    required this.userBookings,
  });

  final String? message;
  final List<UserBooking> userBookings;

  factory BookingWithPackageModel.fromJson(Map<String, dynamic> json){
    return BookingWithPackageModel(
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
    required this.specialistSecoundName,
    required this.stableName,
    required this.profileImage,
    required this.packages,
  });

  final int? bookingId;
  final DateTime? bookingDate;
  final String? paymentMethod;
  final int? specialistId;
  final String? specialistFirstName;
  final String? specialistSecoundName;
  final String? stableName;
  final String? profileImage;
  final List<dynamic> packages;

  factory UserBooking.fromJson(Map<String, dynamic> json){
    return UserBooking(
      bookingId: json["booking_id"],
      bookingDate: DateTime.tryParse(json["booking_date"] ?? ""),
      paymentMethod: json["payment_method"],
      specialistId: json["specialist_id"],
      specialistFirstName: json["specialist_firstName"],
      specialistSecoundName: json["specialist_secoundName"],
      stableName: json["stable_name"],
      profileImage: json["profile_image"],
      packages: json["packages"] == null ? [] : List<dynamic>.from(json["packages"]!.map((x) => x)),
    );
  }

}
