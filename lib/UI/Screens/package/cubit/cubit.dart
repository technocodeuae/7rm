import 'package:bloc/src/cubit.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:sevin_rm/UI/Screens/package/cubit/states.dart';
import 'package:sevin_rm/core/results/result.dart';
import 'package:sevin_rm/data/sources/package/package_data_source.dart';

import '../../../../data/models/stables/stables_information.dart';
import '../../../../data/sources/stables/stables_data_source.dart';

class AllPackageCubitPage extends Cubit<PackageCubitPageStates> {
  AllPackageCubitPage() : super(PackagesInitialStates());

  static AllPackageCubitPage get(context) => BlocProvider.of(context);

  Future<void> getAllPackages() async {
    PackagesRemoteDataImpl packageRemoteDataSourceImpl =
        PackagesRemoteDataImpl();
    try {
      emit(GetPackagesDataLoadingStates());
      Result pack = await packageRemoteDataSourceImpl.getAllPackages();

      print("Error ===> ${pack.error?.message}");
      print("=========\nData ===> ${pack.data}");
      if (pack.data != null) {
        emit(GetPackagesSuccessStates(pack.data!));
      } else {
        emit(GetPackagesErrorStates(pack.error.toString()));
      }
    } catch (e, stack) {
      print("Error In favorite is : $e in $stack");
      emit(GetPackagesErrorStates(e.toString()));
    }
  }


  Future<void> getSpecificPackage({required packageId}) async {
    PackagesRemoteDataImpl packageRemoteDataSourceImpl =
    PackagesRemoteDataImpl();
    try {
      emit(GetSpecificPackageLoadingStates());
      Result pack = await packageRemoteDataSourceImpl.getSpecificPackage(packageId);

      print("Error ===> ${pack.error?.message}");
      print("=========\nData ===> ${pack.data}");
      if (pack.data != null) {
        emit(GetSpecificPackageSuccessStates(pack.data!));
      } else {
        emit(GetSpecificPackageErrorStates(pack.error.toString()));
        print(pack.error.toString());
      }
    } catch (e, stack) {
      print("Error In favorite is : $e in $stack");
      emit(GetSpecificPackageErrorStates(e.toString()));
    }
  }

  Future<void> getStableInformation({required int stableId}) async {
    StablesRemoteDataSourceImpl stablesRemoteDataSourceImpl =
    StablesRemoteDataSourceImpl();
    try {
      emit(GetStableInformationLoadingStates());

      Result<StableInformationModel> stablesInformationData =
      await stablesRemoteDataSourceImpl.getStableInformation(
          stableId: stableId);

      print("Error ===> ${stablesInformationData.error?.message}");
      print("=========\nData ===> ${stablesInformationData.data}");
      if (stablesInformationData.data != null) {
        emit(GetStableInformationSuccessStates(
            stablesInformationData.data as StableInformationModel));
      } else {
        emit(GetStableInformationErrorStates(
            stablesInformationData.error.toString()));
      }
    } catch (e, stack) {
      print("Error In Login is : $e in $stack");
      emit(GetStableInformationErrorStates(e.toString()));
    }
  }


}
