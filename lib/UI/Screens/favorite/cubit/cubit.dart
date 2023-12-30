import 'package:bloc/src/cubit.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:sevin_rm/UI/Screens/favorite/cubit/status.dart';
import 'package:sevin_rm/core/results/result.dart';

import '../../../../data/sources/favourite_horses/favourite_data_source.dart';

class FavoriteCubitPage extends Cubit<FavoriteCubitPageStates> {
  FavoriteCubitPage() : super(FavoriteInitialStates());

  static FavoriteCubitPage get(context) => BlocProvider.of(context);

  Future<void> getFavorite() async {
    FavouriteRemoteDataSourceImpl favoriteRemoteDataSourceImpl =
    FavouriteRemoteDataSourceImpl();
    try {
      emit(GetFavoriteLoadingStates());
      Result fav = await FavouriteRemoteDataSourceImpl().getFavourite();

      print("Error ===> ${fav.error?.message}");
      print("=========\nData ===> ${fav.data}");
      if (fav.data != null) {
        emit(GetFavoriteSuccessStates(fav.data!));
      } else {
        emit(GetFavoriteErrorStates(fav.error.toString()));
      }
    } catch (e, stack) {
      print("Error In favorite is : $e in $stack");
      emit(GetFavoriteErrorStates(e.toString()));
    }
  }

  // Future<void> addFavorite(int stable_id, int horse_id) async {
  //   FavouriteRemoteDataSourceImpl favouriteRemoteDataSourceImpl =
  //       FavouriteRemoteDataSourceImpl();
  //   try {
  //     emit(AddFavInitial());
  //     Result addFav =
  //         await favouriteRemoteDataSourceImpl.addFavourite(stable_id, horse_id);
  //
  //     if (addFav.data != null) {
  //       emit(AddFavSuccess(addFav.data));
  //     } else {
  //       emit(AddFavErrorStates(addFav.error!.message!));
  //     }
  //   } catch (e, stack) {
  //     print("Error In add favorite is : $e in $stack");
  //     emit(AddFavErrorStates("Error is $e"));
  //   }
  // }
//
  Future<void> removeFavorite(int horse_id) async {
    FavouriteRemoteDataSourceImpl favouriteRemoteDataSourceImpl =
    FavouriteRemoteDataSourceImpl();
    try {
      emit(RemoveFavInitial());
      Result removeFav = await favouriteRemoteDataSourceImpl.removeFavourite(
        horse_id);

      if (removeFav.data != null) {
        emit(RemoveFavSuccess(removeFav.data));
        getFavorite();
      } else {
        emit(RemoveFavErrorStates(removeFav.error!.message!));

      }
    } catch (e, stack) {
      print("Error In remove favorite is : $e in $stack");
      emit(RemoveFavErrorStates("Error is $e"));
    }
  }
}
