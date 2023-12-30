import 'package:equatable/equatable.dart';
import 'package:sevin_rm/data/models/trainers/trainers_model.dart';

import '../../../../data/models/search/search_model.dart';

abstract class SearchStates extends Equatable {
  const SearchStates();
}

class InitialSearch extends SearchStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingSearch extends SearchStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SuccessSearch extends SearchStates {
  final SearchModel search;
  const SuccessSearch(this.search);

  @override
  // TODO: implement props
  List<Object?> get props => [search];
}

class ErrorStateSearch extends SearchStates {
  final String error;
  const ErrorStateSearch(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class InitialTrainer extends SearchStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingTrainer extends SearchStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SuccessTrainer extends SearchStates {
  final TrainersModel trainers;
  const SuccessTrainer(this.trainers);

  @override
  // TODO: implement props
  List<Object?> get props => [trainers];
}

class ErrorStateTrainer extends SearchStates {
  final String error;
  const ErrorStateTrainer(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
