import 'package:equatable/equatable.dart';
import 'package:sevin_rm/data/models/profile/update_profile_model.dart';

import '../../../../data/models/logout/logout.dart';
import '../../../../data/models/profile/profile_model.dart';

abstract class ProfileCubitPageStates {}

class InitialProfile extends ProfileCubitPageStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetProfileDataLoadingStates extends ProfileCubitPageStates {}

class GetProfileLoadingStates extends ProfileCubitPageStates {}

class GetProfileSuccessStates extends ProfileCubitPageStates {
  final ProfileModelMe profileModel;
  GetProfileSuccessStates(this.profileModel);
  // TODO: implement props
  List<Object?> get props => [profileModel];
}

/////
class GetProfileErrorStates extends ProfileCubitPageStates {
  final String? error;
  GetProfileErrorStates(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

abstract class UpdateProfileCubitPageStates {}

class UpdateProfileInitialStates extends ProfileCubitPageStates {}

class UpdateProfileDataLoadingStates extends ProfileCubitPageStates {}

class UpdateProfileLoadingStates extends ProfileCubitPageStates {}

class UpdateProfileSuccessStates extends ProfileCubitPageStates {
  final UpdateProfileModel updateProfileModel;
  UpdateProfileSuccessStates(this.updateProfileModel);
  // TODO: implement props
  List<Object?> get props => [updateProfileModel];
}

class UpdateProfileErrorStates extends ProfileCubitPageStates {
  final String? error;
  UpdateProfileErrorStates(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

abstract class LogoutStates extends Equatable {
  const LogoutStates();
}

class InitialLogout extends LogoutStates {
  @override
  List<Object?> get props => [];
}

class LoadingLogout extends LogoutStates {
  @override
  List<Object?> get props => [];
}

class SuccessLogout extends LogoutStates {
  final LogoutModel logoutResult;
  const SuccessLogout(this.logoutResult);
  @override
  List<Object?> get props => [logoutResult];
}

class ErrorStateLogout extends LogoutStates {
  final String error;
  const ErrorStateLogout(this.error);
  @override
  List<Object?> get props => [error];
}
