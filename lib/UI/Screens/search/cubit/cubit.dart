import 'package:bloc/bloc.dart';
import 'package:sevin_rm/UI/Screens/search/cubit/states.dart';

import '../../../../core/results/result.dart';
import '../../../../data/models/search/search_model.dart';
import '../../../../data/sources/search/search_data_source.dart';
import '../../../../data/sources/trainer/trainer_data_source.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitialSearch());

  Future<void> search(String name) async {
    SearchRemoteDataImpl searchDataImpl = SearchRemoteDataImpl();
    try {
      emit(LoadingSearch());
      Result search = await searchDataImpl.search(name);

      if (search.data != null) {
        emit(SuccessSearch(search.data as SearchModel));
      } else {
        emit(ErrorStateSearch(search.error!.message!));
      }
    } catch (e, stack) {
      print("Error In all horses is : $e in $stack");
      emit(ErrorStateSearch("Error is $e"));
    }
  }

  Future<void> trainers() async {
    TrainerRemoteDataImpl trainerDataImpl = TrainerRemoteDataImpl();
    try {
      emit(LoadingTrainer());
      Result trainer = await trainerDataImpl.trainer();

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
