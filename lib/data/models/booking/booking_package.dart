class BookingPackagesModel {
  BookingPackagesModel({
    required this.message,
    required this.status,
  });

  final String? message;
  final bool? status;

  factory BookingPackagesModel.fromJson(Map<String, dynamic> json){
    return BookingPackagesModel(
      message: json["message"],
      status: json["status"],
    );
  }

}
