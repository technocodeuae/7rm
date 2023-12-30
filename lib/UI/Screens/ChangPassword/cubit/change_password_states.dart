import 'package:equatable/equatable.dart';
import 'package:sevin_rm/Core/models/empty_model.dart';
import 'package:sevin_rm/core/results/result.dart';

abstract class ChangePasswordStates extends Equatable {
  const ChangePasswordStates();
}

class Initial extends ChangePasswordStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class Loading extends ChangePasswordStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class Success extends ChangePasswordStates{
  final Result<EmptyModel> changing;
  const Success(this.changing);
  @override
  // TODO: implement props
  List<Object?> get props => [changing];
}
class Error extends ChangePasswordStates{
  final String error;
  const Error(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}