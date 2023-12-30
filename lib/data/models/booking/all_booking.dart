class AllBookingModel {
  AllBookingModel({
    required this.message,
    required this.userBookings,
  });

  final String? message;
  final List<UserBooking> userBookings;

  factory AllBookingModel.fromJson(Map<String, dynamic> json){
    return AllBookingModel(
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
    required this.stableServiceName,
    required this.stableServicePrice,
    required this.stableName,
    required this.profileImage,
    required this.packages,
  });

  final int? bookingId;
  final String? bookingDate;
  final String? paymentMethod;
  final int? specialistId;
  final String? specialistFirstName;
  final String? specialistSecoundName;
  final String? stableServiceName;
  final int? stableServicePrice;
  final String? stableName;
  final String? profileImage;
  final List<Package> packages;

  factory UserBooking.fromJson(Map<String, dynamic> json){
    return UserBooking(
      bookingId: json["booking_id"],
      bookingDate: json["booking_date"].toString(),
      paymentMethod: json["payment_method"],
      specialistId: json["specialist_id"],
      specialistFirstName: json["specialist_firstName"],
      specialistSecoundName: json["specialist_secoundName"],
      stableServiceName: json["stable_service_name"],
      stableServicePrice: json["stable_service_price"],
      stableName: json["stable_name"],
      profileImage: json["profile_image"],
      packages: json["packages"] == null ? [] : List<Package>.from(json["packages"]!.map((x) => Package.fromJson(x))),
    );
  }

}

class Package {
  Package({
    required this.packageId,
    required this.packageName,
    required this.packageDescription,
    required this.services,
  });

  final int? packageId;
  final String? packageName;
  final String? packageDescription;
  final List<dynamic> services;

  factory Package.fromJson(Map<String, dynamic> json){
    return Package(
      packageId: json["package_id"],
      packageName: json["package_name"],
      packageDescription: json["package_description"],
      services: json["services"] == null ? [] : List<dynamic>.from(json["services"]!.map((x) => x)),
    );
  }

}
