import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:sevin_rm/UI/Screens/Register/cubit/sign_up_states.dart';
import 'package:sevin_rm/UI/Screens/login/cubit/status.dart';
import 'package:sevin_rm/data/models/otp/otp_model.dart';
import 'package:sevin_rm/data/sources/auth/auth_remote_data_source.dart';

import '../../../../core/results/result.dart';
import '../../../../data/models/auth/auth_model.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitialRegister());

  Future<void> register(UserAuthenticateModel userAuthenticateModel , File? image , String password) async {
    AuthRemoteDataSourceImpl authRemoteDataSourceImpl =
    const AuthRemoteDataSourceImpl();
    try {
      emit(LoadingRegister());

      Result authentication =
      await authRemoteDataSourceImpl.register(
        userAuthenticateModel: userAuthenticateModel ,
        image: image,
        password: password
      );

      if (authentication.data != null) {
        emit(SuccessRegister(authentication.data as AuthenticateModel));
      } else {
        emit(ErrorStateRegister(authentication.error!.message!));
      }
    } catch (e, stack) {
      print("Error In Register is : $e in $stack");
      emit(ErrorStateRegister("Error is $e"));
    }
  }

  Future<void> sendOtp(String mobile) async {
    AuthRemoteDataSourceImpl authRemoteDataSourceImpl =
    const AuthRemoteDataSourceImpl();
    try {
      emit(LoadingOTP());

      Result otp = await authRemoteDataSourceImpl.sendVerificationCode(mobile);

      if (otp.data != null) {
        emit(SuccessOTP(otp.data as OtpModel));
      } else {
        emit(ErrorStateOTP(otp.error!.message!));
      }
    } catch (e, stack) {
      print("Error In SendOtp is : $e in $stack");
      emit(ErrorStateOTP("Error is $e"));
    }
  }


  Future<void> ValidateMobileNumber(String otpCode , String mobile ) async{
    AuthRemoteDataSourceImpl authRemoteDataSourceImpl = const AuthRemoteDataSourceImpl();
    try{
      emit(LoadingValidate());
      Result validation =
      await authRemoteDataSourceImpl.validateMobileNumber(otpCode, mobile);
      emit(SuccessValidate(validation.data as bool));
    }catch(e,stack){
      print("Error In validateMobileNumber is : $e in $stack");
      emit(ErrorStateValidate("Error is $e"));
    }
  }


  Future<void> sendOtpForgetPassword(String mobile) async {
    AuthRemoteDataSourceImpl authRemoteDataSourceImpl =
    const AuthRemoteDataSourceImpl();
    try {
      emit(LoadingOTP());

      Result otp = await authRemoteDataSourceImpl.otpForgetPassword(mobile);

      if (otp.data != null) {
        emit(SuccessOTP(otp.data as OtpModel));
      } else {
        emit(ErrorStateOTP(otp.error!.message!));
      }
    } catch (e, stack) {
      print("Error In SendOtp is : $e in $stack");
      emit(ErrorStateOTP("Error is $e"));
    }
  }

}
