
import 'package:sevin_rm/data/sources/auth/auth_remote_data_source.dart';
import 'package:bloc/bloc.dart';

import 'change_password_states.dart';
class ChangePasswordCubit extends Cubit<ChangePasswordStates>{
  ChangePasswordCubit() : super(Initial());

  Future<void> changePassword(int phone , String password ) async{
    AuthRemoteDataSourceImpl authRemoteDataSourceImpl = const AuthRemoteDataSourceImpl();
    /*try{
      emit(Loading());
      Result changing =
      await authRemoteDataSourceImpl.fo(phone, password);

      emit(Success(changing));
    }catch(e,stack){
      print("Error In changePassword is : $e in $stack");
      emit(Error("Error is $e"));
    }*/
  }
}