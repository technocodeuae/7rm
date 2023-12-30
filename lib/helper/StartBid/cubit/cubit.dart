import 'package:sevin_rm/data/sources/auctions/auctions_remote_data_source.dart';
import 'package:bloc/bloc.dart';
import 'package:sevin_rm/helper/StartBid/cubit/start_bid_states.dart';
import '../../../../core/results/result.dart';
import '../../../../data/models/auctions/auction_calendar_model.dart';

class StartBidCubit extends Cubit<StartBidStates>{
  StartBidCubit() : super(InitialStartBid());
  Future<void> sendPusher (int auctionId , int horseId , double auctionValue) async{
    AuctionsRemoteDataImpl auctionsRemoteDataImpl =  AuctionsRemoteDataImpl();
    try{
      emit(LoadingStartBid());
      Result bid =
      await auctionsRemoteDataImpl.sendPusher(auctionId, horseId, auctionValue);
      if(bid.data!=null){
        emit(SuccessStartBid(bid.data as bool));
      }
      else{
        emit(ErrorStateStartBid(bid.error!.message!));
      }
    }catch(e,stack){
      print("Error In Start Bid is : $e in $stack");
      emit(ErrorStateStartBid("Error is $e"));
    }
  }
}