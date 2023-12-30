import '../../../../core/net/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../Core/data_source/base_remote_data_source.dart';
import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../models/logout/logout.dart';
import '../endpoints/endpoints.dart';

class LogoutRemoteDataSourceImpl {
  const LogoutRemoteDataSourceImpl();

  Future<Result> logout() async {
    return await RemoteDataSource.request<LogoutModel>(
      converter: (model) => LogoutModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      url: AppEndpoints.baseUrl + AppEndpoints.logoutUrl,
    );
  }
}
///////
