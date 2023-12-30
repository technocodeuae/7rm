import 'package:sevin_rm/UI/Screens/payment/cubit/payment_states.dart';
import 'package:sevin_rm/data/sources/auctions/auctions_remote_data_source.dart';
import 'package:bloc/bloc.dart';
import '../../../../core/results/result.dart';
import '../../../../data/models/auctions/auction_calendar_model.dart';


class PaymentCubit extends Cubit<PaymentStates>{
  PaymentCubit() : super(InitialPayment());

  Future<void> acceptpayment(int horseId)  async{
    AuctionsRemoteDataImpl auctionsRemoteDataImpl =  AuctionsRemoteDataImpl();
    try{
      emit(LoadingPayment());
      Result payment =
      await auctionsRemoteDataImpl.acceptPayment(horseId);

      if(payment.data!=null){
        emit(SuccessPayment(payment.data as bool));
      }
      else{
        emit(ErrorStatePayment(payment.error!.message!));
      }
    }catch(e,stack){
      print("Error In accept payment is : $e in $stack");
      emit(ErrorStatePayment("Error is $e"));
    }
  }




}