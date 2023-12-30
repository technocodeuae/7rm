import 'package:sevin_rm/data/models/horse/abstract_horse.dart';

class AllHorses {
  AllHorses({
    required this.horses,
  });

  final List<AbstractHorse> horses;

  factory AllHorses.fromJson(Map<String, dynamic> json){
    return AllHorses(
      horses: json["horses"] == null ? [] : List<AbstractHorse>.from(json["horses"]!.map((x) => AbstractHorse.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "horses": horses.map((x) => x.toJson()).toList(),
  };
}
