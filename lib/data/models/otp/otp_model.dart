class OtpModel {
  OtpModel({
     this.status,
     this.message,
     this.data,
  });

  final bool? status;
  final String? message;
  final String? data;

  factory OtpModel.fromJson(Map<String, dynamic> json){
    return OtpModel(
      status: json["status"],
      message: json["message"],
      data: json["data"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };

}
