import 'package:sevin_rm/data/models/package/all_package_model.dart';
import 'package:sevin_rm/data/models/package/specific_package_name.dart';

import '../../../../data/models/stables/stables_information.dart';

abstract class PackageCubitPageStates {}

class PackagesInitialStates extends PackageCubitPageStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetPackagesDataLoadingStates extends PackageCubitPageStates {}

class GetPackagesLoadingStates extends PackageCubitPageStates {}

class GetPackagesSuccessStates extends PackageCubitPageStates {
  final AllPackagesModel allPackagesModel;
  GetPackagesSuccessStates(this.allPackagesModel);
  // TODO: implement props
  List<Object?> get props => [allPackagesModel];
}

class ErrorStatePackages extends PackageCubitPageStates {
  final String? error;
  ErrorStatePackages(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class GetPackagesErrorStates extends PackageCubitPageStates {
  final String? error;
  GetPackagesErrorStates(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}



class GetSpecificPackageLoadingStates extends PackageCubitPageStates {}

class GetSpecificPackageSuccessStates extends PackageCubitPageStates {
  final SpecificPackageModel specificPackageModel;
  GetSpecificPackageSuccessStates(this.specificPackageModel);
  // TODO: implement props
  List<Object?> get props => [specificPackageModel];
}

class GetSpecificPackageErrorStates extends PackageCubitPageStates {
  final String? error;
  GetSpecificPackageErrorStates(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}



class GetStableInformationLoadingStates extends PackageCubitPageStates {}

class GetStableInformationSuccessStates extends PackageCubitPageStates {
  final StableInformationModel stableInformationModel;
  GetStableInformationSuccessStates(this.stableInformationModel);
  // TODO: implement props
  List<Object?> get props => [stableInformationModel];
}

class GetStableInformationErrorStates extends PackageCubitPageStates {
  final String? error;
  GetStableInformationErrorStates(this.error);
  // TODO: implement props
  List<Object?> get props => [error];
}
