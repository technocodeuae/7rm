//
import 'package:bloc/bloc.dart';
import 'package:sevin_rm/data/models/auctions/all_auctions.dart';
import 'package:sevin_rm/data/models/auctions/all_auctions_today.dart';
import 'package:sevin_rm/data/sources/auctions/auctions_remote_data_source.dart';

import '../../../../core/results/result.dart';
import 'auctions_states.dart';

class AllAuctionCubit extends Cubit<AuctionsStates> {
  AllAuctionCubit() : super(InitialAuctions());

  Future<void> getAllAuctions(bool isSortedByPrice) async {
    AuctionsRemoteDataImpl auctionsRemoteDataImpl = AuctionsRemoteDataImpl();
    try {
      emit(LoadingAuctions());
      Result allauctions =
          await auctionsRemoteDataImpl.getAllAuctions(isSortedByPrice);
      if (allauctions.data != null) {
        emit(SuccessAuctions(allauctions.data as AllAuctions));
      } else {
        emit(ErrorStateAuctions(allauctions.error!.message!));
      }
    } catch (e, stack) {
      print("Error In all auctions is : $e in $stack");
      emit(ErrorStateAuctions("Error is $e"));
    }
  }

  Future<void> getAllAuctionsToday() async {
    AuctionsRemoteDataImpl auctionsRemoteDataImpl = AuctionsRemoteDataImpl();
    try {
      emit(LoadingAuctionsToday());
      Result today = await auctionsRemoteDataImpl.getAllAuctionsToday();
      if (today.data != null) {
        emit(SuccessAuctionsToday(today.data as AuctionsToday));
      } else {
        emit(ErrorStateAuctionsToday(today.error!.message!));
      }
    } catch (e, stack) {
      print("Error In all auctions Today is : $e in $stack");
      emit(ErrorStateAuctionsToday("Error is $e"));
    }
  }
}
