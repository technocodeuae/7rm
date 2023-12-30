import 'package:equatable/equatable.dart';
import 'package:sevin_rm/Core/models/empty_model.dart';

abstract class ResetPasswordStates extends Equatable {
  const ResetPasswordStates();
}

class Initial extends ResetPasswordStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class Loading extends ResetPasswordStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class Success extends ResetPasswordStates{
  final EmptyModel reset;
  const Success(this.reset);
  @override
  // TODO: implement props
  List<Object?> get props => [reset];
}
class ErrorState extends ResetPasswordStates{
  final String error;
  const ErrorState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}