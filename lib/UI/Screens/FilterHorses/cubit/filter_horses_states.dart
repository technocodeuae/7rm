import 'package:equatable/equatable.dart';

//
import '../../../../data/models/horse/all_horse.dart';

abstract class FilterHorseStates extends Equatable {
  const FilterHorseStates();
}

class InitialFilter extends FilterHorseStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingFilter extends FilterHorseStates {
  @override
  // TODO: implement props
  //
  List<Object?> get props => [];
}

class SuccessFilter extends FilterHorseStates {
  final AllHorses horses;
  const SuccessFilter(this.horses);

  @override
  // TODO: implement props
  List<Object?> get props => [horses];
}

class ErrorStateFilter extends FilterHorseStates {
  final String error;
  const ErrorStateFilter(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
