import 'package:equatable/equatable.dart';
import 'package:sevin_rm/data/models/auth/auth_model.dart';

abstract class LoginStates extends Equatable {
  const LoginStates();
}

class Initial extends LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Loading extends LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Success extends LoginStates {
  final AuthenticateModel authentication;
  const Success(this.authentication);
  @override
  // TODO: implement props
  List<Object?> get props => [authentication];
}

class ErrorState extends LoginStates {
  final String error;
  const ErrorState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
