import 'package:sevin_rm/data/sources/auctions/auctions_remote_data_source.dart';
import 'package:bloc/bloc.dart';
import '../../../../core/results/result.dart';
import '../../../../data/models/auctions/auction_calendar_model.dart';
import 'auctions_calendar_states.dart';

/*
class AuctionCheckerCubit extends Cubit<AuctionsCheckerStates>{
  AuctionCheckerCubit() : super(InitialCheck());
  Future<void> checkIfPayment(int auctionId , int index) async{
    AuctionsRemoteDataImpl auctionsRemoteDataImpl =  AuctionsRemoteDataImpl();
    try{
      emit(LoadingCheck());
      Result checked =
      await auctionsRemoteDataImpl.checkIfPayment(auctionId);

      if(checked.data!=null){
        emit(SuccessCheck(checked.data as bool,index));
      }
      else{
        emit(ErrorStateCheck(checked.error!.message!));
      }
    }catch(e,stack){
      print("Error In check payment is : $e in $stack");
      emit(ErrorStateCheck("Error is $e"));
    }
  }
}
*/

class AuctionsCalendarCubit extends Cubit<AuctionsCalendarStates>{
  AuctionsCalendarCubit() : super(InitialCalendar());

  Future<void> getAuctionsCalendar() async{
    AuctionsRemoteDataImpl auctionsRemoteDataImpl =  AuctionsRemoteDataImpl();
    try{
      emit(LoadingCalendar());
      Result auctioncal =
      await auctionsRemoteDataImpl.getCalendarAuctions();

      if(auctioncal.data!=null){
        emit(SuccessCalendar(auctioncal.data as AuctionCalendarModel));
      }
      else{
        emit(ErrorStateCalendar(auctioncal.error!.message!));
      }
    }catch(e,stack){
      print("Error In all horses is : $e in $stack");
      emit(ErrorStateCalendar("Error is $e"));
    }
  }

 /* Future<void> checkIfPayment(int auctionId , int index) async{
    AuctionsRemoteDataImpl auctionsRemoteDataImpl =  AuctionsRemoteDataImpl();
    try{
      emit(LoadingCheck());
      Result checked =
      await auctionsRemoteDataImpl.checkIfPayment(auctionId);

      if(checked.data!=null){
        emit(SuccessCheck(checked.data as bool,index));
      }
      else{
        emit(ErrorStateCheck(checked.error!.message!));
      }
    }catch(e,stack){
      print("Error In check payment is : $e in $stack");
      emit(ErrorStateCheck("Error is $e"));
    }
  }*/




}