import 'package:bloc/src/cubit.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:sevin_rm/UI/Screens/booking/cubit/states.dart';
import 'package:sevin_rm/core/results/result.dart';

import '../../../../data/models/booking/add_order_model.dart';
import '../../../../data/models/stables/stables_information.dart';
import '../../../../data/sources/all-horses/horse_remote_data_source.dart';
import '../../../../data/sources/booking/booking_data_source.dart';
import '../../../../data/sources/favourite_horses/favourite_data_source.dart';
import '../../../../data/sources/stables/stables_data_source.dart';

class BookingCubitPage extends Cubit<BookingCubitPageStates> {
  BookingCubitPage() : super(AddOrderInitial());

  static BookingCubitPage get(context) => BlocProvider.of(context);

  Future<void> addOrder(
      { required int specialistId,
        required int  stableId,
        required int  stableServiceId,
        required String   paymentMethod,
        required String bookingDate}) async {
    BookingRemoteDataSourceImpl bookingRemoteDataSourceImpl =
        BookingRemoteDataSourceImpl();
    try {
      emit(AddOrderLoading());
      Result addOrder = await bookingRemoteDataSourceImpl.addOrder(
          specialistId, stableId, stableServiceId, paymentMethod, bookingDate);

      if (addOrder.data != null) {
        emit(AddOrderSuccess(addOrder.data));
      } else {
        emit(AddOrderErrorStates(addOrder.error!.message!));
        print(addOrder.error!.message!);
      }
    } catch (e, stack) {
      print("Error In add order is : $e in $stack");
      emit(AddOrderErrorStates("Error is $e"));
    }
  }


  Future<void>  bookingAvailableTimes(String data,
      int specialistId,{required int stableId,required int serviceId,}) async {
    BookingRemoteDataSourceImpl bookingRemoteDataSourceImpl =
    BookingRemoteDataSourceImpl();
    try {
      emit(BookingAvailableTimesLoading());
      Result bookingAvailableTimes = await bookingRemoteDataSourceImpl.bookingAvailableTimes(

          data, stableId,
          specialistId,serviceId);

      if (bookingAvailableTimes.data != null) {
        emit(BookingAvailableTimesSuccess(bookingAvailableTimes.data));
      } else {
        emit(BookingAvailableTimesError(bookingAvailableTimes.error!.message!));

        print(bookingAvailableTimes.error!.message!);
      }
    } catch (e, stack) {
      print("Error In add order is : $e in $stack");
      emit(BookingAvailableTimesError("Error is $e"));
    }
  }

  //bookingPackages


  Future<void>  bookingPackages({required int stableId,required int packageId,required int bookingId}) async {
    BookingRemoteDataSourceImpl bookingRemoteDataSourceImpl =
    BookingRemoteDataSourceImpl();
    try {
      emit(BookingPackageLoading());
      Result bookingAvailableTimes = await bookingRemoteDataSourceImpl.bookingPackages(
        stableId: stableId,
        packageId: packageId,
        bookingId: bookingId,
      );

      if (bookingAvailableTimes.data != null) {
        emit(BookingPackageSuccess(bookingAvailableTimes.data));
      } else {
        emit(BookingPackageError(bookingAvailableTimes.error!.message!));

        print(bookingAvailableTimes.error!.message!);
      }
    } catch (e, stack) {
      print("Error In add order is : $e in $stack");
      emit(BookingPackageError("Error is $e"));
    }
  }




  Future<void> isHorseInFavorite({required int horseId}) async{
    HorseRemoteDataImpl detailHorseDataImpl =  HorseRemoteDataImpl();
    try{
      emit(IsHorseInFavoriteLoading());
      Result isHoesInFavoriteModel =
      await detailHorseDataImpl.isHorseInFavorite(horseId:horseId );

      if(isHoesInFavoriteModel.data!=null){
        emit(IsHorseInFavoriteSuccess(isHoesInFavoriteModel.data));
      }
      else{
        emit(IsHorseInFavoriteErrorState(isHoesInFavoriteModel.error!.message!));
      }
    }catch(e,stack){
      print("Error In detail horse is : $e in $stack");
      emit(IsHorseInFavoriteErrorState("Error is $e"));
    }
  }

  Future<void>  bookingUserInStable({required int stableId,}) async {
    BookingRemoteDataSourceImpl bookingRemoteDataSourceImpl =
    BookingRemoteDataSourceImpl();
    try {
      emit(BookingUserInStableLoading());
      Result bookingUserInStable = await bookingRemoteDataSourceImpl.bookingUserInStable(
        stableId: stableId,

      );

      if (bookingUserInStable.data != null) {
        emit(BookingUserInStableSuccess(bookingUserInStable.data));
      } else {
        emit(BookingUserInStableError(bookingUserInStable.error!.message!));

        print(bookingUserInStable.error!.message!);
      }
    } catch (e, stack) {
      print("Error In add order is : $e in $stack");
      emit(BookingUserInStableError("Error is $e"));
    }
  }


  Future<void> getStableInformation({required int stableId}) async {
    StablesRemoteDataSourceImpl stablesRemoteDataSourceImpl =
    StablesRemoteDataSourceImpl();
    try {
      emit(GetStableInformationLoadingStates());

      Result<StableInformationModel> stablesInformationData =
      await stablesRemoteDataSourceImpl.getStableInformation(
          stableId: stableId);

      print("Error ===> ${stablesInformationData.error?.message}");
      print("=========\nData ===> ${stablesInformationData.data}");
      if (stablesInformationData.data != null) {
        emit(GetStableInformationSuccessStates(
            stablesInformationData.data as StableInformationModel));
      } else {
        emit(GetStableInformationErrorStates(
            stablesInformationData.error.toString()));
      }
    } catch (e, stack) {
      print("Error In Login is : $e in $stack");
      emit(GetStableInformationErrorStates(e.toString()));
    }
  }


  Future<void> addFavorite(int horseId) async {
    FavouriteRemoteDataSourceImpl favouriteRemoteDataSourceImpl =
    FavouriteRemoteDataSourceImpl();
    try {
      emit(AddFavInitial());
      Result addFav =
      await favouriteRemoteDataSourceImpl.addFavourite(horseId);

      if (addFav.data != null) {
        emit(AddFavSuccess(addFav.data));
        isHorseInFavorite(horseId: horseId);
      } else {
        emit(AddFavErrorStates(addFav.error!.message!));
      }
    } catch (e, stack) {
      print("Error In add favorite is : $e in $stack");
      emit(AddFavErrorStates("Error is $e"));
    }
  }

  Future<void> removeFavorite(int horseId) async {
    FavouriteRemoteDataSourceImpl favouriteRemoteDataSourceImpl =
    FavouriteRemoteDataSourceImpl();
    try {
      emit(RemoveFavInitial());
      Result removeFav = await favouriteRemoteDataSourceImpl.removeFavourite(
          horseId);

      if (removeFav.data != null) {
        emit(RemoveFavSuccess(removeFav.data));
        isHorseInFavorite(horseId: horseId);
      } else {
        emit(RemoveFavErrorStates(removeFav.error!.message!));
      }
    } catch (e, stack) {
      print("Error In remove favorite is : $e in $stack");
      emit(RemoveFavErrorStates("Error is $e"));
    }
  }

}
