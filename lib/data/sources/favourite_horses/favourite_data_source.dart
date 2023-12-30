import 'package:sevin_rm/core/net/http_method.dart';
import 'package:sevin_rm/data/models/favourite/add_favorite_model.dart';

import '../../../../core/results/result.dart';
import '../../../Core/data_source/base_remote_data_source.dart';
import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../models/favourite/favourite_model.dart';
import '../../models/favourite/remove_favorite_model.dart';
import '../endpoints/endpoints.dart';

class FavouriteRemoteDataSourceImpl extends FavouriteRemoteDataSource {
  @override
  Future<Result<FavoriteModel>> getFavourite() async {
    return await RemoteDataSource.request<FavoriteModel>(
      converter: (model) => FavoriteModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      url: AppEndpoints.baseUrl + AppEndpoints.favorite,
    );
  }

////
  Future<Result<AddFavoriteModel>> addFavourite(
       int horse_id) async {
    return await RemoteDataSource.request<AddFavoriteModel>(
      converter: (model) => AddFavoriteModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: {

        "horse_id": horse_id,
      },
      url: AppEndpoints.baseUrl + AppEndpoints.addFavorite,
    );
  }

  Future<Result<RemoveFavoriteModel>> removeFavourite(
      int horse_id) async {
    return await RemoteDataSource.request<RemoveFavoriteModel>(
      converter: (model) => RemoveFavoriteModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: {
        "horse_id": horse_id,
      },
      url: AppEndpoints.baseUrl + AppEndpoints.removeFavorite,
    );
  }
}

abstract class FavouriteRemoteDataSource {
  const FavouriteRemoteDataSource();
  Future<Result<FavoriteModel>> getFavourite();
  Future<Result<AddFavoriteModel>> addFavourite(int horse_id);
  Future<Result<RemoveFavoriteModel>> removeFavourite(
   int horse_id);
}

//////////
