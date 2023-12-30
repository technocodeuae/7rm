import '../../../../data/models/favourite/favourite_model.dart';
import '../../../../data/models/favourite/remove_favorite_model.dart';
abstract class FavoriteCubitPageStates {}
class FavoriteInitialStates extends FavoriteCubitPageStates {
@override
// TODO: implement props
List<Object?> get props => [];
}
class GetFavoriteDataLoadingStates extends FavoriteCubitPageStates {
@override
// TODO: implement props
List<Object?> get props => [];
}
//
class GetFavoriteLoadingStates extends FavoriteCubitPageStates {
@override
// TODO: implement props
List<Object?> get props => [];
}
class GetFavoriteSuccessStates extends FavoriteCubitPageStates {
final FavoriteModel favoriteModel;
GetFavoriteSuccessStates(this.favoriteModel);
// TODO: implement props
List<Object?> get props => [favoriteModel];
}
class ErrorStateFavorite extends FavoriteCubitPageStates {
final String error;
ErrorStateFavorite(this.error);
@override
List<Object?> get props => [error];
}
class GetFavoriteErrorStates extends FavoriteCubitPageStates {
final String? error;
GetFavoriteErrorStates(this.error);
@override
// TODO: implement props
List<Object?> get props => [error];
}
class AddFavInitial extends FavoriteCubitPageStates {
@override
// TODO: implement props
List<Object?> get props => [];
}
class AddFavLoading extends FavoriteCubitPageStates {}
class AddFavSuccess extends FavoriteCubitPageStates {
final FavoriteModel addFavoriteModel;
AddFavSuccess(this.addFavoriteModel);
// TODO: implement props
List<Object?> get props => [addFavoriteModel];
}
class AddFavError extends FavoriteCubitPageStates {}
class AddFavErrorStates extends FavoriteCubitPageStates {
final String? error;
AddFavErrorStates(this.error);
@override
// TODO: implement props
List<Object?> get props => [error];
}
class RemoveFavInitial extends FavoriteCubitPageStates {
@override
// TODO: implement props
List<Object?> get props => [];
}
//
class RemoveFavLoading extends FavoriteCubitPageStates {}
class RemoveFavSuccess extends FavoriteCubitPageStates {
final RemoveFavoriteModel removeFavoriteModel;
RemoveFavSuccess(this.removeFavoriteModel);
// TODO: implement props
List<Object?> get props => [removeFavoriteModel];
}
class RemoveFavError extends FavoriteCubitPageStates {}
class RemoveFavErrorStates extends FavoriteCubitPageStates {
final String? error;
RemoveFavErrorStates(this.error);
@override
// TODO: implement props
List<Object?> get props => [error];
}