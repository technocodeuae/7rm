class IsHoesInFavoriteModel {
  IsHoesInFavoriteModel({
    required this.message,
    required this.status,
  });

  final String? message;
  final bool? status;

  factory IsHoesInFavoriteModel.fromJson(Map<String, dynamic> json){
    return IsHoesInFavoriteModel(
      message: json["message"],
      status: json["status"],
    );
  }

}
