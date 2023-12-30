import 'package:bloc/src/cubit.dart';
import 'package:sevin_rm/core/results/result.dart';
import 'package:sevin_rm/data/models/auctions/all_my_auctions.dart';
import 'package:sevin_rm/data/sources/auctions/auctions_remote_data_source.dart';

import 'my_auctions_states.dart';

//
class MyAuctionsCubit extends Cubit<MyAuctionsState> {
  MyAuctionsCubit() : super(InitialStatesMyAuctions());

  Future<void> getAllMyAuctions() async {
    AuctionsRemoteDataImpl auctionsRemoteDataImpl = AuctionsRemoteDataImpl();
    try {
      emit(LoadingStatesMyAuctions());
      Result myauctions = await auctionsRemoteDataImpl.getAllMyAuctions();
      if (myauctions.data != null) {
        emit(SuccessStatesMyAuctions(myauctions.data as MyAuctions));
      } else {
        emit(ErrorStateMyAuctions(myauctions.error.toString()));
      }
    } catch (e, stack) {
      print("Error In My Auctions is : $e in $stack");
      emit(ErrorStateMyAuctions(e.toString()));
    }
  }
}
