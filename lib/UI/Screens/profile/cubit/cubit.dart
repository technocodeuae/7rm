

import 'dart:io';

import 'package:bloc/src/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:sevin_rm/Core/di/di_manager.dart';
import 'package:sevin_rm/UI/Screens/profile/cubit/states.dart';
import 'package:sevin_rm/core/results/result.dart';
import 'package:sevin_rm/data/models/profile/profile_model.dart';

import '../../../../Core/shared_prefs/shared_prefs.dart';
import '../../../../data/models/logout/logout.dart';
import '../../../../data/sources/logout/logout_data_source.dart';
import '../../../../data/sources/profile/profile_data_source.dart';

import '../../../../data/sources/profile/update_profile_data_source.dart';

import '../../login/login.dart';


class ProfileCubitPage extends Cubit<ProfileCubitPageStates> {
  ProfileCubitPage() : super(InitialProfile());

  static ProfileCubitPage get(context) => BlocProvider.of(context);

  Future<void> getProfile() async {
    ProfileRemoteDataSourceImpl profileRemoteDataSourceImpl =
        ProfileRemoteDataSourceImpl();
    try {
      emit(GetProfileLoadingStates());

      Result<ProfileModelMe> profileData;

      profileData = await profileRemoteDataSourceImpl.getMyProfile();

      print("Error ===> ${profileData.error?.message}");
      print("=========\nData ===> ${profileData.data}");
      if (profileData.data != null) {
        emit(GetProfileSuccessStates(profileData.data as ProfileModelMe));
      } else {
        emit(GetProfileErrorStates(profileData.error.toString()));
        print(profileData.error.toString());
      }
    } catch (e, stack) {
      print("Error In Login is : $e in $stack");
      emit(GetProfileErrorStates(e.toString()));
    }
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? mobile,
    String? dateOfBirth,
    String? gender,
    String? userName,
    String? location,
    File? userImage,
  }) async {
    UpdateProfileRemoteDataSourceImpl updateprofileRemoteDataSourceImpl =
        UpdateProfileRemoteDataSourceImpl();
    try {
      emit(UpdateProfileLoadingStates());
      Result update = await updateprofileRemoteDataSourceImpl.update(
        gender: gender,
        mobile: mobile,
        dateOfBirth: dateOfBirth,
        userName: userName,
        email: email,
        firstName: firstName,
        lastName: lastName,location: location,
        // userImage: userImage
      );

      if (update.data != null) {
        emit(UpdateProfileSuccessStates(update.data));
      } else {
        emit(UpdateProfileErrorStates(update.error!.message!));
      }
    } catch (e, stack) {
      print("Error In update is : $e in $stack");
      emit(UpdateProfileErrorStates("Error is $e"));
    }
  }
}

class LogoutCubit extends Cubit<LogoutStates> {
  LogoutCubit() : super(InitialLogout());
  static LogoutCubit get(context) => BlocProvider.of(context);

  Future<void> logout(context) async {
    LogoutRemoteDataSourceImpl logoutRemoteDataSourceImpl =
        LogoutRemoteDataSourceImpl();
    try {
      emit(LoadingLogout());
      Result logoutResult = await logoutRemoteDataSourceImpl.logout();

      if (logoutResult.data != null) {

        emit(SuccessLogout(logoutResult.data as LogoutModel));
        DIManager.findDep<SharedPrefs>().setToken(null);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return LoginW();
            }));

      } else {
        emit(ErrorStateLogout(logoutResult.error!.message!));
        print(logoutResult.error!.message!);
      }
    } catch (e, stack) {
      print("Error In Logout is : $e in $stack");
      emit(ErrorStateLogout("Error is $e"));
    }
  }
}
