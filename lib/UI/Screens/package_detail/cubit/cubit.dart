import 'package:bloc/src/cubit.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:sevin_rm/UI/Screens/package_detail/cubit/states.dart';
import 'package:sevin_rm/core/results/result.dart';
import 'package:sevin_rm/data/sources/package/package_data_source.dart';

class PackageDetailCubitPage extends Cubit<PackageDetailCubitPageStates> {
  PackageDetailCubitPage() : super(PackageInitialStates());

  static PackageDetailCubitPage get(context) => BlocProvider.of(context);

  Future<void> getPackage() async {
    PackagesRemoteDataImpl packageRemoteDataSourceImpl =
        PackagesRemoteDataImpl();
    try {
      emit(PackageLoadingStates());
      Result pack = await PackagesRemoteDataImpl().getAllPackages();

      print("Error ===> ${pack.error?.message}");
      print("=========\nData ===> ${pack.data}");
      if (pack.data != null) {
        emit(PackageSuccessStates(pack.data!));
      } else {
        emit(ErrorStatePackage(pack.error.toString()));
      }
    } catch (e, stack) {
      print("Error In favorite is : $e in $stack");
      emit(GetPackageErrorStates(e.toString()));
    }
  }
}
