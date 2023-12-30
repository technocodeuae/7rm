
import 'package:sevin_rm/Core/models/empty_model.dart';
import 'package:sevin_rm/data/sources/auth/auth_remote_data_source.dart';
import 'package:bloc/bloc.dart';

import '../../../../core/results/result.dart';
import 'reset_password_states.dart';
class ResetPasswordCubit extends Cubit<ResetPasswordStates>{
  ResetPasswordCubit() : super(Initial());

  Future<void> resetPassword(String phone , String password ) async{
    AuthRemoteDataSourceImpl authRemoteDataSourceImpl = const AuthRemoteDataSourceImpl();
    try{
      emit(Loading());
      Result reset =
      await authRemoteDataSourceImpl.resetPassword(phone, password);
      if(reset.data!=null){
        emit(Success(reset.data as EmptyModel));
      }else{
        emit(ErrorState(reset.error!.message!));
      }
    }catch(e,stack){
      print("Error In changePassword is : $e in $stack");
      emit(ErrorState("Error is $e"));
    }
  }
}