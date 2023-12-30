
import 'package:sevin_rm/UI/Screens/HorseDetail/cubit/horse_detail_states.dart';
import 'package:sevin_rm/data/models/horse/horse.dart';
import 'package:sevin_rm/data/sources/all-horses/horse_remote_data_source.dart';
import 'package:bloc/bloc.dart';

import '../../../../core/results/result.dart';
import '../../../../data/models/horse/favorite_horse.dart';
class HorseDetailCubit extends Cubit<DetailHorseStates>{
  HorseDetailCubit() : super(Initial());
  double auctionBid = 0.0;
  Future<void> getHorseDetail(int Id) async{
    HorseRemoteDataImpl detailHorseDataImpl =  HorseRemoteDataImpl();
    try{
      emit(Loading());
      Result detail =
      await detailHorseDataImpl.getDetailHorse(Id);

      if(detail.data!=null){
        emit(Success(detail.data as Horse));
      }
      else{
        emit(ErrorState(detail.error!.message!));
      }
    }catch(e,stack){
      print("Error In detail horse is : $e in $stack");
      emit(ErrorState("Error is $e"));
    }
  }
}