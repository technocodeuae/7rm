import 'package:bloc/bloc.dart';
import 'package:sevin_rm/Core/di/di_manager.dart';
import 'package:sevin_rm/Core/shared_prefs/shared_prefs.dart';
import 'package:sevin_rm/UI/Screens/login/cubit/status.dart';
import 'package:sevin_rm/data/sources/auth/auth_remote_data_source.dart';

import '../../../../core/results/result.dart';
import '../../../../data/models/auth/auth_model.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(Initial());

  Future<void> login(String phone, String password) async {
    AuthRemoteDataSourceImpl authRemoteDataSourceImpl =
        const AuthRemoteDataSourceImpl();
    try {
      emit(Loading());

      Result authentication =
          await authRemoteDataSourceImpl.login(phone, password);



      if (authentication.data != null) {
        emit(Success(authentication.data as AuthenticateModel));
      } else {
        emit(ErrorState(authentication.error!.message!));
      }
    } catch (e, stack) {
      print("Error In Login is : $e in $stack");
      emit(ErrorState("Error is $e"));
    }
  }
}
