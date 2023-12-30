import 'package:sevin_rm/data/models/booking/add_order_model.dart';
import 'package:sevin_rm/data/models/booking/booking_availabel_times.dart';

import '../../../../data/models/booking/booking_package.dart';
import '../../../../data/models/booking/booking_user_stable.dart';
import '../../../../data/models/favourite/add_favorite_model.dart';
import '../../../../data/models/favourite/remove_favorite_model.dart';
import '../../../../data/models/horse/favorite_horse.dart';
import '../../../../data/models/stables/stables_information.dart';

abstract class BookingCubitPageStates {}

class AddOrderInitial extends BookingCubitPageStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddOrderLoading extends BookingCubitPageStates {}

class AddOrderSuccess extends BookingCubitPageStates {
  final AddOrderModel addOrderModel;
  AddOrderSuccess(this.addOrderModel);
  // TODO: implement props
  List<Object?> get props => [addOrderModel];
}

class AddOrderError extends BookingCubitPageStates {}

class AddOrderErrorStates extends BookingCubitPageStates {
  final String? error;
  AddOrderErrorStates(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}



class BookingAvailableTimesLoading extends BookingCubitPageStates {}

class BookingAvailableTimesSuccess extends BookingCubitPageStates {
  final BookingAvailableTimes bookingAvailableTimes;
  BookingAvailableTimesSuccess(this.bookingAvailableTimes);
  // TODO: implement props
  List<Object?> get props => [bookingAvailableTimes];
}

class BookingAvailableTimesError extends BookingCubitPageStates {

  final String? error;
  BookingAvailableTimesError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}


class BookingPackageLoading extends BookingCubitPageStates {}

class BookingPackageSuccess extends BookingCubitPageStates {
  final BookingPackagesModel bookingPackagesModel;
  BookingPackageSuccess(this.bookingPackagesModel);
  // TODO: implement props
  List<Object?> get props => [BookingPackagesModel];
}

class BookingPackageError extends BookingCubitPageStates {

  final String? error;
  BookingPackageError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}




class BookingUserInStableLoading extends BookingCubitPageStates {}

class BookingUserInStableSuccess extends BookingCubitPageStates {
  final BookingUserInStableModel bookingUserInStableModel;
  BookingUserInStableSuccess(this.bookingUserInStableModel);
  // TODO: implement props
  List<Object?> get props => [BookingPackagesModel];
}

class BookingUserInStableError extends BookingCubitPageStates {

  final String? error;
  BookingUserInStableError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}




class GetStableInformationLoadingStates extends BookingCubitPageStates {}

class GetStableInformationSuccessStates extends BookingCubitPageStates {
  final StableInformationModel stableInformationModel;
  GetStableInformationSuccessStates(this.stableInformationModel);
  // TODO: implement props
  List<Object?> get props => [stableInformationModel];
}

class GetStableInformationErrorStates extends BookingCubitPageStates {
  final String? error;
  GetStableInformationErrorStates(this.error);
  // TODO: implement props
  List<Object?> get props => [error];
}

class AddFavInitial extends BookingCubitPageStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddFavLoading extends BookingCubitPageStates {}

class AddFavSuccess extends BookingCubitPageStates {
  final AddFavoriteModel addFavoriteModel;
  AddFavSuccess(this.addFavoriteModel);
  // TODO: implement props
  List<Object?> get props => [addFavoriteModel];
}

class AddFavError extends BookingCubitPageStates {}

class AddFavErrorStates extends BookingCubitPageStates {
  final String? error;
  AddFavErrorStates(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class RemoveFavInitial extends BookingCubitPageStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//
class RemoveFavLoading extends BookingCubitPageStates {}

class RemoveFavSuccess extends BookingCubitPageStates {
  final RemoveFavoriteModel removeFavoriteModel;
  RemoveFavSuccess(this.removeFavoriteModel);
  // TODO: implement props
  List<Object?> get props => [removeFavoriteModel];
}

class RemoveFavError extends BookingCubitPageStates {}

class RemoveFavErrorStates extends BookingCubitPageStates {
  final String? error;
  RemoveFavErrorStates(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}



class IsHorseInFavoriteLoading extends BookingCubitPageStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class IsHorseInFavoriteSuccess extends BookingCubitPageStates{
  final IsHoesInFavoriteModel isHoesInFavoriteModel;
   IsHorseInFavoriteSuccess(this.isHoesInFavoriteModel);
  @override
  // TODO: implement props
  List<Object?> get props => [isHoesInFavoriteModel];
}
class IsHorseInFavoriteErrorState extends BookingCubitPageStates{
  final String error;
   IsHorseInFavoriteErrorState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}