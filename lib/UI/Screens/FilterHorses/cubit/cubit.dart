import 'package:bloc/bloc.dart';
import 'package:sevin_rm/UI/Screens/FilterHorses/cubit/filter_horses_states.dart';
import 'package:sevin_rm/data/models/horse/all_horse.dart';
import 'package:sevin_rm/data/sources/all-horses/horse_remote_data_source.dart';

import '../../../../core/results/result.dart';

class FilterHorsesCubit extends Cubit<FilterHorseStates> {
  FilterHorsesCubit() : super(InitialFilter());

  Future<void> getAllHorses(int auctionId) async {
    HorseRemoteDataImpl detailHorseDataImpl = HorseRemoteDataImpl();
    try {
      emit(LoadingFilter());
      Result allhorses = await detailHorseDataImpl.getAllHorses(auctionId);

      if (allhorses.data != null) {
        emit(SuccessFilter(allhorses.data as AllHorses));
      } else {
        emit(ErrorStateFilter(allhorses.error!.message!));
      }
    } catch (e, stack) {
      print("Error In all horses is : $e in $stack");
      emit(ErrorStateFilter("Error is $e"));
    }
  }
}
