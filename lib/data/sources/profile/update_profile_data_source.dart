import 'dart:io';

import 'package:sevin_rm/Core/data_source/base_remote_data_source.dart';
import 'package:sevin_rm/core/results/result.dart';
import 'package:sevin_rm/data/models/profile/update_profile_model.dart';
import 'package:sevin_rm/data/sources/endpoints/endpoints.dart';

import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../../core/net/http_method.dart';

abstract class UpdateProfileRemoteDataSource {
  // Future<Result> getCalendarAuctions();

  Future<Result> update({
    String? firstName,
    String? lastName,
    String? userName,
    String? email,
    String? dateOfBirth,
    String? gender,
    String? mobile,
    String? location,
    File? userImage,
  });
}

//
class UpdateProfileRemoteDataSourceImpl extends UpdateProfileRemoteDataSource {
  @override
  Future<Result> update({
    String? firstName,
    String? lastName,
    String? userName,
    String? email,
    String? dateOfBirth,
    String? gender,
    String? mobile,
    String? location,
    File? userImage,
  }) async {
    return await RemoteDataSource.request<UpdateProfileModel>(
      converter: (model) => UpdateProfileModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: {
        "first_name": firstName,
        "last_name": lastName,
        "user_name": userName,
        "email": email,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "mobile": mobile,
        'about':location,
        // 'user_image':userImage,
      },
      url: "${AppEndpoints.baseUrl}${AppEndpoints.updateProfile}",
    );
  }
}
