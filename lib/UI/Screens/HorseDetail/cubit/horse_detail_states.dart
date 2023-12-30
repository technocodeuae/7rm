import 'package:equatable/equatable.dart';
import 'package:sevin_rm/core/results/result.dart';
import 'package:sevin_rm/data/models/auth/auth_model.dart';
import 'package:sevin_rm/data/models/horse/horse.dart';

import '../../../../data/models/horse/favorite_horse.dart';

abstract class DetailHorseStates extends Equatable {
  const DetailHorseStates();
}

class InitialPusher {
  final double auctionValue;
  InitialPusher(this.auctionValue);

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class Initial extends DetailHorseStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class Loading extends DetailHorseStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class Success extends DetailHorseStates{
  final Horse horse;
  const Success(this.horse);
  @override
  // TODO: implement props
  List<Object?> get props => [horse];
}
class ErrorState extends DetailHorseStates{
  final String error;
  const ErrorState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
