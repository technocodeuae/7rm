
import 'package:sevin_rm/Core/models/empty_model.dart';
import 'package:sevin_rm/UI/Screens/verifaction/cubit/verification_states.dart';
import 'package:sevin_rm/data/models/otp/otp_model.dart';
import 'package:sevin_rm/data/sources/auth/auth_remote_data_source.dart';
import 'package:bloc/bloc.dart';

import '../../../../core/results/result.dart';
class VerificationCubit extends Cubit<VerificationState>{
  VerificationCubit() : super(Initial());


  /*Future<void> ValidateMobileNumber(String otpCode , int mobile ) async{
    AuthRemoteDataSourceImpl authRemoteDataSourceImpl = const AuthRemoteDataSourceImpl();
    try{
      emit(Loading());
      Result<EmptyModel> validation =
      await authRemoteDataSourceImpl.validateMobileNumber(otpCode, mobile);
      emit(Success(validation));
    }catch(e,stack){
      print("Error In validateMobileNumber is : $e in $stack");
      emit(Error("Error is $e"));
    }
  }*/
}