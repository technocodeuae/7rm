
import 'package:sevin_rm/UI/Screens/ServiceScreen/cubit/services_states.dart';
import 'package:bloc/bloc.dart';
import 'package:sevin_rm/data/sources/service/services_remote_data_source.dart';

import '../../../../core/results/result.dart';
import '../../../../data/models/services/servicesModel.dart';
class ServicesCubit extends Cubit<ServicesStates>{
  ServicesCubit() : super(Initial());

  Future<void> getServices(int id) async{
    ServicesData servicesDataImpl = ServicesData();
    try{
      emit(Loading());
      Result serve =
      await servicesDataImpl.getServices(id);
      if(serve.data!=null){
        emit(Success(serve.data as ServicesModel ));
      }else{
        emit(ErrorState(serve.error!.message!));
      }
    }catch(e,stack){
      print("Error In services is : $e in $stack");
      emit(ErrorState("Error is $e"));
    }
  }
}