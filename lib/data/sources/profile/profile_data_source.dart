import 'package:sevin_rm/core/net/http_method.dart';

import '../../../../core/results/result.dart';
import '../../../Core/data_source/base_remote_data_source.dart';
import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../models/profile/profile_model.dart';
import '../endpoints/endpoints.dart';

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  @override
  Future<Result<ProfileModelMe>> getMyProfile() async {
    //
    return await RemoteDataSource.request<ProfileModelMe>(
      converter: (model) => ProfileModelMe.fromJson(model),
      method: HttpMethod.GET,
      url: AppEndpoints.baseUrl + AppEndpoints.profile,
      headers: {
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
    );
  }
}

abstract class ProfileRemoteDataSource {
  const ProfileRemoteDataSource();
  Future<Result<ProfileModelMe>> getMyProfile();
}
/////
