class StablesPackagesServicesCategoryModel {
  StablesPackagesServicesCategoryModel({
    required this.services,
    required this.stables,
    required this.packages,
  });

  final List<ServicesCategoryModel> services;
  final List<StableCategoryModel> stables;
  final List<PackageCategoryModel> packages;

  factory StablesPackagesServicesCategoryModel.fromJson(Map<String, dynamic> json){
    return StablesPackagesServicesCategoryModel(
      services: json["services"] == null ? [] : List<ServicesCategoryModel>.from(json["services"]!.map((x) => ServicesCategoryModel.fromJson(x))),
      stables: json["stables"] == null ? [] : List<StableCategoryModel>.from(json["stables"]!.map((x) => StableCategoryModel.fromJson(x))),
      packages: json["packages"] == null ? [] : List<PackageCategoryModel>.from(json["packages"]!.map((x) => PackageCategoryModel.fromJson(x))),
    );
  }

}

class PackageCategoryModel {
  PackageCategoryModel({
    required this.packageId,
    required this.stableId,
    required this.price,
    required this.name,
    required this.image,
    required this.description,
    required this.imagePath,
    required this.services,
  });

  final int? packageId;
  final int? stableId;
  final int? price;
  final String? name;
  final String? image;
  final String? imagePath;
  final dynamic description;
  final List<PackageService> services;

  factory PackageCategoryModel.fromJson(Map<String, dynamic> json){
    return PackageCategoryModel(
      packageId: json["package_id"],
      stableId: json["stable_id"],
      price: json["price"],
      name: json["name"],
      image: json["image"],
      imagePath: json["image_path"],
      description: json["description"],
      services: json["services"] == null ? [] : List<PackageService>.from(json["services"]!.map((x) => PackageService.fromJson(x))),
    );
  }

}

class PackageService {
  PackageService({
    required this.serviceId,
    required this.serviceName,
    required this.servicePrice,
  });

  final int? serviceId;
  final String? serviceName;
  final int? servicePrice;

  factory PackageService.fromJson(Map<String, dynamic> json){
    return PackageService(
      serviceId: json["service_id"],
      serviceName: json["service_name"],
      servicePrice: json["service_price"],
    );
  }

}

class ServicesCategoryModel {
  ServicesCategoryModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
  });

  final int? id;
  final String? name;
  final String? imagePath;
  final int? price;

  factory ServicesCategoryModel.fromJson(Map<String, dynamic> json){
    return ServicesCategoryModel(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      imagePath: json["image_path"],
    );
  }

}

class StableCategoryModel {
  StableCategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.longitude,
    required this.latitude,
    required this.evaluations,
    required this.imagePath,
  });

  final int? id;
  final String? name;
  final String? description;
  final String? longitude;
  final String? latitude;
  final String? imagePath;
  final List<Evaluation> evaluations;

  factory StableCategoryModel.fromJson(Map<String, dynamic> json){
    return StableCategoryModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      imagePath: json["image_path"],
      evaluations: json["evaluations"] == null ? [] : List<Evaluation>.from(json["evaluations"]!.map((x) => Evaluation.fromJson(x))),
    );
  }

}
class Evaluation {
  Evaluation({
    required this.stableId,
    required this.averageEvaluation,
  });

  final int? stableId;
  final String? averageEvaluation;

  factory Evaluation.fromJson(Map<String, dynamic> json){
    return Evaluation(
      stableId: json["stable_id"],
      averageEvaluation: json["average_evaluation"].toString(),
    );
  }

}