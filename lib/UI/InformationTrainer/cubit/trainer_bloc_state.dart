
import 'package:sevin_rm/data/models/trainers/show_trainer.dart';

abstract class TrainerBlocState {}

class TrainerBlocInitial extends TrainerBlocState {}



class LoadingTrainer extends TrainerBlocState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SuccessTrainer extends TrainerBlocState {
  final ShowTrainerModel trainers;
  SuccessTrainer(this.trainers);

  @override
  // TODO: implement props
  List<Object?> get props => [trainers];
}

class ErrorStateTrainer extends TrainerBlocState {
  final String error;
   ErrorStateTrainer(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
