import 'package:flutter/material.dart';
import 'package:sevin_rm/UI/Screens/FilterHorses/filterHorse.dart';
import 'package:sevin_rm/UI/Screens/HorseDetail/detail_horse.dart';
import 'package:sevin_rm/UI/Screens/component/Widght.dart';
import 'package:sevin_rm/UI/Screens/conset/Const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevin_rm/helper/error_dialog_helper.dart';
import 'package:sevin_rm/helper/snack_bar_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/payment_states.dart';

class PaymentPage extends StatefulWidget {
  int auction_id;
  int horse_id;
  PaymentPage({Key? key , required this.auction_id , required this.horse_id}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
       create: (context) => PaymentCubit(),
      child: BlocConsumer<PaymentCubit,PaymentStates>(
        listener: (context, state) {
            if(state is ErrorStatePayment){
              DialogHelper.errorDialog(context, "Error", state.error);
            }else if (state is SuccessPayment){
              if(state.payment)
              {
                SnackBarHelper.mySnackBar("Payment Successfully", context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (
                        BuildContext context) =>
                        DetailsHorses(
                            auction_id: widget.auction_id ,
                        horse_id: widget.horse_id,),
                  ),

                );
              }
            }
        },
          builder: (context,state) {
          return Scaffold(
            body: Center(
              child:
              state is LoadingPayment ? Center(child: CircularProgressIndicator(color: Color1))
              : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Accept Payment",style: TextStyle(color: Color1 , fontSize: 35)),
                  Image.asset("assets/images/img_18.png"),
                  ButtonStaic(
                      onTap: () {
                          BlocProvider.of<PaymentCubit>(context).acceptpayment(widget.horse_id);
                      },
                      title: "Pay",
                      colors: [Color1, Color1],
                      radius: 25.0,
                      widthContainer:
                      MediaQuery.of(context).size.width * 0.80,
                      heightContainer: 50.0,
                      boxShadow: [
                        BoxShadow(
                          color: Color1.withOpacity(0.5),
                          spreadRadius: 2.0,
                          blurRadius: 10.0,
                          offset: const Offset(-1, 6),
                        ),
                      ],
                      beginGrident: Alignment.topLeft,
                      endGrident: Alignment.bottomRight,
                      colorText: Color3,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
