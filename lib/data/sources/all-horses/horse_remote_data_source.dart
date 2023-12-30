

import 'package:sevin_rm/Core/data_source/base_remote_data_source.dart';
import 'package:sevin_rm/data/models/horse/all_horse.dart';

import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../../core/net/http_method.dart';
import '../../../core/results/result.dart';
import '../../models/horse/favorite_horse.dart';
import '../../models/horse/horse.dart';
import '../endpoints/endpoints.dart';

abstract class HorseRemoteDataSource{

  Future<Result> getDetailHorse(int id);
  Future<Result<IsHoesInFavoriteModel>> isHorseInFavorite({required horseId});

  Future<Result> getAllHorses(int auctionId);

}

class HorseRemoteDataImpl extends HorseRemoteDataSource{
  @override
  Future<Result> getAllHorses(int auctionId) async{
    return await RemoteDataSource.request<AllHorses>(
      converter: (model) => AllHorses.fromJson(model),
      method: HttpMethod.POST,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: {
        "auction_id":auctionId
      },
      url: "${AppEndpoints.baseUrl}${AppEndpoints.auctionsHorses}",
    );
   }

  @override
  Future<Result> getDetailHorse(int id) async {
    return await RemoteDataSource.request<Horse>(
      converter: (model) => Horse.fromJson(model),
      method: HttpMethod.GET,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: null,
      url: "${AppEndpoints.baseUrl}${AppEndpoints.detailHorseUrl}/$id",
    );
  }

  @override
  Future<Result<IsHoesInFavoriteModel>> isHorseInFavorite({required horseId}) async {
    return await RemoteDataSource.request<IsHoesInFavoriteModel>(
      converter: (model) => IsHoesInFavoriteModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: {
        "horse_id":horseId,
      },
      url: "${AppEndpoints.baseUrl}${AppEndpoints.isHorseInFavorite}",
    );
  }

}