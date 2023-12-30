import 'package:equatable/equatable.dart';
import 'package:sevin_rm/data/models/filter/filters_model.dart';

abstract class FiltersStates extends Equatable {
  const FiltersStates();
}

class InitialFilters extends FiltersStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingFilters extends FiltersStates {
  @override
  // TODO: implement props
  //
  List<Object?> get props => [];
}

//
class SuccessFilters extends FiltersStates {
  final FiltersModel filter;
  const SuccessFilters(this.filter);

  @override
  // TODO: implement props
  List<Object?> get props => [filter];
}

class ErrorStateFilters extends FiltersStates {
  final String error;
  const ErrorStateFilters(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
