import 'package:equatable/equatable.dart';
import 'package:sevin_rm/data/models/services/servicesModel.dart';

abstract class ServicesStates extends Equatable {
  const ServicesStates();
}

class Initial extends ServicesStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class Loading extends ServicesStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class Success extends ServicesStates{
  final ServicesModel reset;
  const Success(this.reset);
  @override
  // TODO: implement props
  List<Object?> get props => [reset];
}
class ErrorState extends ServicesStates{
  final String error;
  const ErrorState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}