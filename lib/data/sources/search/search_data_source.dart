import 'package:sevin_rm/Core/data_source/base_remote_data_source.dart';
import 'package:sevin_rm/data/models/search/search_model.dart';

import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../../core/net/http_method.dart';
import '../../../core/results/result.dart';
import '../endpoints/endpoints.dart';

abstract class SearchRemoteDataSource {
  Future<Result> search(String name);
}

class SearchRemoteDataImpl extends SearchRemoteDataSource {
  @override
  Future<Result> search(String name) async {
    return await RemoteDataSource.request<SearchModel>(
      converter: (model) => SearchModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      url: "${AppEndpoints.baseUrl}${AppEndpoints.search}?name=$name",
    );
  }
}
