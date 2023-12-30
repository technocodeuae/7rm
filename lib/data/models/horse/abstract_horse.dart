class AbstractHorse {
  AbstractHorse({
     this.id,
     this.sire,
     this.dam,
     this.gender,
     this.birthDate,
     this.price,
     this.restTime,
     this.images,
  });
  final int? id;
  final String? sire;
  final String? dam;
  final String? gender;
  final String? birthDate;
  final String? price;
  final String? restTime;
  final String? images;

  factory AbstractHorse.fromJson(Map<String, dynamic> json){
    return AbstractHorse(
      id : json["id"],
      sire: json["Sire"],
      dam: json["Dam"],
      gender: json["Gender"],
      birthDate: json["Birth Date"],
      price: json["Price"],
      restTime: json["rest_time"],
      images: json["images"],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "id":id,
        "Sire": sire,
        "Dam": dam,
        "Gender": gender,
        "Birth Date": birthDate,
        "Price": price,
        "rest_time": restTime,
        "images": images,
      };
}