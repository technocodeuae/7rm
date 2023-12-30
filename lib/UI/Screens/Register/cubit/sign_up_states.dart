import 'package:equatable/equatable.dart';
import 'package:sevin_rm/data/models/auth/auth_model.dart';
import 'package:sevin_rm/data/models/otp/otp_model.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}


class InitialRegister extends RegisterState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingRegister extends RegisterState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SuccessRegister extends RegisterState {
  final AuthenticateModel authenticationRegister;
  const SuccessRegister(this.authenticationRegister);
  @override
  // TODO: implement props
  List<Object?> get props => [authenticationRegister];
}

class ErrorStateRegister extends RegisterState {
  final String error;
  const ErrorStateRegister(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}



class InitialValidate extends RegisterState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingValidate extends RegisterState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SuccessValidate extends RegisterState {
  final bool validation;
  const SuccessValidate(this.validation);
  @override
  // TODO: implement props
  List<Object?> get props => [validation];
}

class ErrorStateValidate extends RegisterState {
  final String error;
  const ErrorStateValidate(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}



class InitialOTP extends RegisterState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingOTP extends RegisterState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SuccessOTP extends RegisterState {
  final OtpModel otpModel;
  const SuccessOTP(this.otpModel);
  @override
  // TODO: implement props
  List<Object?> get props => [otpModel];
}

class ErrorStateOTP extends RegisterState {
  final String error;
  const ErrorStateOTP(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
