import 'package:sevin_rm/data/models/booking/all_booking.dart';

import '../../../../core/results/result.dart';
import '../../../Core/data_source/base_remote_data_source.dart';
import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../models/stables/best_stables_model.dart';
import '../../models/stables/stable_nearby_model.dart';
import '../../models/stables/stable_trainers_model.dart';
import '../../models/stables/stables_information.dart';
import '../../models/stables/stables_model.dart';
import '../endpoints/endpoints.dart';
import 'package:sevin_rm/core/net/http_method.dart';

class StablesRemoteDataSourceImpl extends StablesRemoteDataSource {
  @override
  Future<Result<StablesModel>> geAllStables() async {
    return await RemoteDataSource.request<StablesModel>(
      converter: (model) => StablesModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      url: AppEndpoints.baseUrl + AppEndpoints.allStables,
    );
  }


  @override
  Future<Result<AllBookingModel>> getAllBooking() async {
    return await RemoteDataSource.request<AllBookingModel>(
      converter: (model) => AllBookingModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {
        'Authorization':'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      url: AppEndpoints.baseUrl + AppEndpoints.allBooking,
    );
  }

  @override
  Future<Result<BestStablesModel>> getBestStables() async {
    return await RemoteDataSource.request<BestStablesModel>(
      converter: (model) => BestStablesModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      url: AppEndpoints.baseUrl + AppEndpoints.bestStables,
    );
  }

  @override
  Future<Result<StablesNearbyModel>> getNearbyStables() async {
    return await RemoteDataSource.request<StablesNearbyModel>(
      converter: (model) => StablesNearbyModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {
        "Authorization":
            DIManager.findDep<SharedPrefs>().getToken().toString() ?? ''
      },
      url: AppEndpoints.baseUrl + AppEndpoints.nearbyStables,
    );
  }
  @override
  Future<Result<StablesNearbyModel>> getNearbyStablesLocations(double long , double lat) async {
    var query = {
      // "lat":45.678901,
      // "long":123.456789
      "lat":lat,
      "long":long
    };
    final uri1 = Uri.parse(AppEndpoints.baseUrl + AppEndpoints.stableLocationsUrl).replace(queryParameters:
    query.map((key, value) => MapEntry(key, value.toString())));
    return await RemoteDataSource.request<StablesNearbyModel>(
      converter: (model) => StablesNearbyModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      url: uri1.toString(),
    );
  }


  @override
  Future<Result<StableTrainersModel>> getStableTrainers() async {
    return await RemoteDataSource.request<StableTrainersModel>(
      converter: (model) => StableTrainersModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      url: '${AppEndpoints.baseUrl}mobile/trainers',
    );
  }

  @override
  Future<Result<StableInformationModel>> getStableInformation({
    required int stableId,
}) async {
    return await RemoteDataSource.request<StableInformationModel>(
      converter: (model) => StableInformationModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {
        'Accept':'application/json'
      },
      data: {
        'stable_id':stableId
      },
      url: "${AppEndpoints.baseUrl}${AppEndpoints.stableInformation}",
    );
  }


}

abstract class StablesRemoteDataSource {
  const StablesRemoteDataSource();

  Future<Result<StablesModel>> geAllStables();
  Future<Result<AllBookingModel>> getAllBooking();

  Future<Result<BestStablesModel>> getBestStables();

  Future<Result<StablesNearbyModel>> getNearbyStables();

  Future<Result<StablesNearbyModel>> getNearbyStablesLocations(double long , double lat);

  Future<Result<StableTrainersModel>> getStableTrainers();
  Future<Result<StableInformationModel>> getStableInformation({
    required int stableId
});
}
