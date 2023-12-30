import 'package:bloc/bloc.dart';
import 'package:sevin_rm/UI/Screens/filter/cubit/states.dart';
import 'package:sevin_rm/data/models/filter/filters_model.dart';

import '../../../../core/results/result.dart';
import '../../../../data/sources/filter/filter_data_source.dart';

class FiltersCubit extends Cubit<FiltersStates> {
  FiltersCubit() : super(InitialFilters());

  Future<void> filter(
      {required int auctionId,
      required int minAge,
      required int maxAge,
      String? price}) async {
    FilterRemoteDataImpl filterRemoteDataImpl = FilterRemoteDataImpl();
    try {
      //
      emit(LoadingFilters());
      Result filter =
          await filterRemoteDataImpl.filter(minAge, maxAge, price!, auctionId);

      if (filter.data != null) {
        emit(SuccessFilters(filter.data as FiltersModel));
      } else {
        emit(ErrorStateFilters(filter.error!.message!));
      }
    } catch (e, stack) {
      print("Error In all horses is : $e in $stack");
      emit(ErrorStateFilters("Error is $e"));
    }
  }
}
