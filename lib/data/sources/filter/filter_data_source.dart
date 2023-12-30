import 'package:sevin_rm/Core/data_source/base_remote_data_source.dart';
import 'package:sevin_rm/data/models/filter/filters_model.dart';

import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../../core/net/http_method.dart';
import '../../../core/results/result.dart';
import '../endpoints/endpoints.dart';

abstract class FilterRemoteDataSource {
  Future<Result> filter(int minAge, int maxAge, String? price, int auctionId);
}

class FilterRemoteDataImpl extends FilterRemoteDataSource {
  @override
  Future<Result> filter(
      int minAge, int maxAge, String? price, int auctionId) async {
    return await RemoteDataSource.request<FiltersModel>(
      converter: (model) => FiltersModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {
        ////
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: {
        "auction_id": auctionId,
      },
      url:
          "${AppEndpoints.baseUrl}${AppEndpoints.filter}?min_age=$minAge&max_age=$maxAge&price=$price",
    );
  }
}
