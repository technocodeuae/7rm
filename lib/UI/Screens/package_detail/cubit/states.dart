import 'package:sevin_rm/data/models/package/all_package_model.dart';

abstract class PackageDetailCubitPageStates {}

class PackageInitialStates extends PackageDetailCubitPageStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PackageDataiLoadingStates extends PackageDetailCubitPageStates {}

class PackageLoadingStates extends PackageDetailCubitPageStates {}

class PackageSuccessStates extends PackageDetailCubitPageStates {
  final AllPackagesModel allPackagesModel;
  PackageSuccessStates(this.allPackagesModel);
  // TODO: implement props
  List<Object?> get props => [allPackagesModel];
}

class ErrorStatePackage extends PackageDetailCubitPageStates {
  final String error;
  ErrorStatePackage(this.error);
  @override
  List<Object?> get props => [error];
}

class GetPackageErrorStates extends PackageDetailCubitPageStates {
  final String? error;
  GetPackageErrorStates(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
