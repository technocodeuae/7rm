import 'package:sevin_rm/Core/data_source/base_remote_data_source.dart';
import 'package:sevin_rm/core/results/result.dart';
import 'package:sevin_rm/data/models/package/all_package_model.dart';
import 'package:sevin_rm/data/sources/endpoints/endpoints.dart';

import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../../core/net/http_method.dart';
import '../../models/package/specific_package_name.dart';

abstract class PackagesRemoteDataSource {
  // Future<Result> getCalendarAuctions();

  Future<Result> getAllPackages();
  Future<Result> getSpecificPackage(int packageId);
}

class PackagesRemoteDataImpl extends PackagesRemoteDataSource {
  @override
  Future<Result<AllPackagesModel>> getAllPackages() async {
    return await RemoteDataSource.request<AllPackagesModel>(
        converter: (model) => AllPackagesModel.fromJson(model),
        method: HttpMethod.GET,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          // 'Authorization':
          //     'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
        },
        data: null,
        url: AppEndpoints.baseUrl + AppEndpoints.package);
  }

  @override
  Future<Result> getSpecificPackage(int packageId) async {
    return await RemoteDataSource.request<SpecificPackageModel>(
      converter: (model) => SpecificPackageModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: {
        "package_id":packageId
      },
      url: "${AppEndpoints.baseUrl}${AppEndpoints.package}",
    );
  }
}
