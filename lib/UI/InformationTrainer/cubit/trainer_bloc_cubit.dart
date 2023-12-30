import 'package:bloc/bloc.dart';

import 'package:sevin_rm/UI/InformationTrainer/cubit/trainer_bloc_state.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';


import '../../../core/results/result.dart';
import '../../../data/models/trainers/show_trainer.dart';
import '../../../data/sources/trainer/trainer_data_source.dart';


class TrainerBlocCubit extends Cubit<TrainerBlocState> {
  TrainerBlocCubit() : super(TrainerBlocInitial());

  static TrainerBlocCubit get(context) => BlocProvider.of(context);

  Future<void> showTrainers({required int trainerId}) async {
    TrainerRemoteDataImpl trainerDataImpl = TrainerRemoteDataImpl();
    try {
      emit(LoadingTrainer());
      Result<ShowTrainerModel> trainer = await trainerDataImpl.showTrainer(trainerId: trainerId);

      if (trainer.data != null) {
        emit(SuccessTrainer(trainer.data!));
      } else {
        emit(ErrorStateTrainer(trainer.error!.message!));
      }
    } catch (e, stack) {
      print("Error In trainers is : $e in $stack");
      emit(ErrorStateTrainer("Error is $e"));
    }
  }

}
