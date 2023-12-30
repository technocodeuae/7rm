import 'package:equatable/equatable.dart';
import 'package:sevin_rm/Core/models/empty_model.dart';
import 'package:sevin_rm/core/results/result.dart';

abstract class VerificationState extends Equatable {
  const VerificationState();
}

class Initial extends VerificationState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class Loading extends VerificationState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class Success extends VerificationState{
  final Result<EmptyModel> verify;
  const Success(this.verify);
  @override
  // TODO: implement props
  List<Object?> get props => [verify];
}
class Error extends VerificationState{
  final String error;
  const Error(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}